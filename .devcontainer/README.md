# Dev Container

A sandboxed environment for AI-assisted development with Claude Code.

## Prerequisites

- Docker Desktop running
- VS Code with Dev Containers extension, or `devcontainer` CLI

## Getting Started

### Option 1: VS Code

1. Open this repo in VS Code
2. Press `Cmd+Shift+P` and select "Dev Containers: Reopen in Container"
3. Wait for the container to build

### Option 2: CLI

```bash
# Build and start the container
devcontainer up --workspace-folder .

# Open a shell in the container
devcontainer exec --workspace-folder . bash
```

## Using Claude

Once inside the container:

```bash
# Normal mode (with permission prompts)
claude

# Permissive mode (no prompts)
claude-yolo
```

## Jekyll Development

```bash
# Install dependencies (runs automatically on container creation)
bundle install

# Serve locally with live reload
bundle exec jekyll serve --baseurl /blog --host 0.0.0.0

# Preview drafts too
bundle exec jekyll serve --baseurl /blog --host 0.0.0.0 --drafts
```

Visit http://localhost:4000/blog/ (trailing slash required).

> `--host 0.0.0.0` is required so the server is reachable from the host machine. Without it, Jekyll binds to `127.0.0.1` inside the container.

## GitHub Setup

Run `gh-setup` to configure GitHub authentication. This is required for pushing code and creating PRs.

See [GITHUB.md](./GITHUB.md) for details on the authentication setup and security model.

## Troubleshooting

- **Container won't start**: Make sure Docker Desktop is running. Check `docker ps` to see if an old container is stuck.
- **`bundle install` fails**: The container has `ruby-full`, `build-essential`, and `zlib1g-dev` pre-installed. If a native gem still fails, you may need to add its system dependency to the Dockerfile and rebuild.
- **Claude can't reach the API**: The container runs a firewall that only allows traffic to `api.anthropic.com`, GitHub, npm, rubygems, and a few other domains. Verify with `curl -I https://api.anthropic.com`.
- **`git push` fails with credential errors**: VS Code/Cursor inject their own credential helper into `/etc/gitconfig` (system-level) and `~/.gitconfig` (global), which intercepts `gh auth git-credential`. The container handles this two ways: `GIT_CONFIG_NOSYSTEM=1` in `containerEnv` skips `/etc/gitconfig`, and `postStartCommand` resets the global credential helper to `gh auth` on each start. If you're still hitting credential issues, verify with: `git config --show-origin --get-all credential.helper`.
- **Port 4000 not accessible**: The container maps `-p 4000:4000`. Make sure nothing else is using that port on your host.

## Notes

- The container includes network restrictions via iptables (see `init-firewall.sh`)
- Your `ANTHROPIC_API_KEY` environment variable needs to be available to the container
- Working directory inside the container is `/workspace`
