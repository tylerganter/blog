# Getting Started: Devcontainer + Claude Code

## Prerequisites

- **Docker Desktop** running
- **devcontainer CLI** installed (`npm install -g @devcontainers/cli`)
- **`ANTHROPIC_API_KEY`** exported in your shell (the container picks it up automatically)

## 1. Build and start the container

```bash
devcontainer up --workspace-folder .
```

This builds the Docker image (Node 20 base, Ruby, Jekyll, Claude Code, gh CLI, firewall, zsh) and starts the container with `/workspace` mapped to your repo root. Port 4000 is forwarded for the Jekyll dev server.

The first build takes a few minutes. Subsequent starts reuse the cached image.

## 2. Enter the container

```bash
devcontainer exec --workspace-folder . bash
```

You're now at `/workspace` inside the container as the `node` user.

## 3. Install Ruby dependencies

```bash
bundle install
```

This installs the gems from `Gemfile` (Jekyll, minima theme, plugins). Gems are stored in `/home/node/.gems` so they persist across shell sessions within the same container.

## 4. Run Claude Code

```bash
claude
```

Or for fully autonomous mode (no permission prompts):

```bash
claude-yolo
```

Claude Code is pre-installed globally in the container. Your `ANTHROPIC_API_KEY` is passed through from the host.

## 5. Build and serve the site

```bash
# Build only (generates docs/ directory)
bundle exec jekyll build

# Or serve locally with live reload
bundle exec jekyll serve --baseurl /blog
```

Visit http://localhost:4000/blog/ from your host machine.

To preview drafts: `bundle exec jekyll serve --baseurl /blog --drafts`

## 6. GitHub App authentication

Configure the GitHub App so Claude can create branches, push code, and open PRs under its own identity (`tylerganter-claude-bot[bot]`):

```bash
gh-setup
```

You'll need your App ID, Installation ID, and private key (`.pem` file). To pre-place the key so the script auto-detects it:

```bash
# From the host machine
mkdir -p .devcontainer/.gh-app
cp /path/to/your-app.private-key.pem .devcontainer/.gh-app/private-key.pem
```

This directory is gitignored. See [.devcontainer/GITHUB.md](.devcontainer/GITHUB.md) for the full setup guide and security model.

### Installing the app on a new repo

If you already have the GitHub App from another repo:

1. Go to `https://github.com/settings/installations`
2. Click **Configure** on your app
3. Under **Repository access**, add the new repo
4. Run `gh-setup` inside the container with the same App ID, the Installation ID from the URL, and the same `.pem` key

## Troubleshooting

- **Container won't start**: Make sure Docker Desktop is running. Check `docker ps` to see if an old container is stuck.
- **`bundle install` fails**: The container has `ruby-full`, `build-essential`, and `zlib1g-dev` pre-installed. If a native gem still fails, you may need to add its system dependency to the Dockerfile and rebuild.
- **Claude can't reach the API**: The container runs a firewall that only allows traffic to `api.anthropic.com`, GitHub, npm, rubygems, and a few other domains. Verify with `curl -I https://api.anthropic.com`.
- **Port 4000 not accessible**: The container maps `-p 4000:4000`. Make sure nothing else is using that port on your host.

## What's already in the container

| Tool | Version / Notes |
|------|----------------|
| Node | 20.x |
| Ruby | System ruby-full (Debian) |
| Jekyll + Bundler | Installed via `gem install` |
| Claude Code | Latest (`@anthropic-ai/claude-code`) |
| gh CLI | Debian package |
| git-delta | 0.18.2 |
| zsh + Powerlevel10k | Pre-configured |
| Firewall | iptables allowlist (GitHub, Anthropic, npm, rubygems) |
