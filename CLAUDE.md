# Project Context for Claude Code

## Critical Rules

IMPORTANT: **AI Instruction File Maintenance** — For every PR, you MUST do the following for `CLAUDE.md`: (1) Add one helpful sentence that captures a useful insight, convention, or lesson learned from the PR's changes (e.g., a new pattern introduced, a gotcha discovered, or a clarification of existing behavior). (2) Scan `CLAUDE.md` for stale or out-of-date information (e.g., references to renamed directories, removed features, changed commands, or outdated architecture descriptions). If stale content is found, warn the user about what is outdated and where, but do NOT delete or modify the stale content unless the user explicitly asks you to.

## Development Environment

- **Platform**: macOS with devcontainer CLI or Cursor (VS Code-based dev container)
- **Container runtime**: Docker via devcontainer CLI or Cursor
- **Working directory**: `/workspace` (inside container)

## Local Development Server

```bash
bundle exec jekyll serve --baseurl /blog --host 0.0.0.0
```

Then visit http://localhost:4000/blog/ (trailing slash required — WEBrick returns 404 without it).

To preview drafts:

```bash
bundle exec jekyll serve --baseurl /blog --host 0.0.0.0 --drafts
```

**Note**: `--host 0.0.0.0` is required so the server is reachable from outside the devcontainer. Without it, Jekyll binds to `127.0.0.1` (container-local only) and the host machine gets `ERR_EMPTY_RESPONSE`.

## Project Overview

Personal blog built with Jekyll, served via GitHub Pages at `tylerganter.com/blog/`.

### Key Directories
- `/workspace/_site/` - Generated site output (local builds; not committed — GitHub Actions builds and deploys automatically)
- `/workspace/_posts/` - Published blog posts (Markdown)
- `/workspace/_drafts/` - Unpublished drafts (Markdown)
- `/workspace/_layouts/` - Custom HTML layouts (optional, theme provides defaults)

### Creating a New Post

Posts go in `_posts/` with filename format `YYYY-MM-DD-title-slug.md`:

```markdown
---
title: "Post Title"
date: 2026-02-12
tags: [ai, climbing]
---

Content in Markdown...
```

### Building the Site

```bash
bundle exec jekyll build
```

Output goes to `_site/` (Jekyll default). Deployment is handled automatically by GitHub Actions on push to `main` — no need to commit build output.

## Git & GitHub Workflow

All changes go through **feature branches and pull requests** — never push directly to `main`. The `main` branch is protected with GitHub Rulesets requiring PR approval before merging.

Claude authenticates as a **GitHub App** (`tylerganter-claude-bot[bot]`), which gives it its own identity separate from the repo owner. This means the owner can approve PRs that Claude creates.

For the full workflow (branching, committing, PRs, syncing), see the [git-github skill](.claude/skills/git-github/SKILL.md). For authentication setup and the security model, see [GITHUB.md](.devcontainer/GITHUB.md).

<!-- TODO: Define autonomy boundaries — what Claude can do proactively (e.g., commit, push, open PRs on feature branches) vs. what requires asking the user first. -->

## Container Environment

The dev container runs with a **network firewall** that restricts outbound traffic to GitHub, Anthropic, npm/rubygems, and VS Code marketplace only. See [.devcontainer/README.md](.devcontainer/README.md) for container setup and [init-firewall.sh](.devcontainer/init-firewall.sh) for the full allowlist.

## Lessons Learned

- VS Code/Cursor inject a credential helper into `/etc/gitconfig` inside devcontainers; `GIT_CONFIG_NOSYSTEM=1` in `containerEnv` prevents this from overriding `gh auth git-credential`.

## Deployment

The site is deployed via **GitHub Actions** (`.github/workflows/pages.yml`) — on every push to `main`, the workflow builds with Jekyll and deploys via `actions/deploy-pages`. After merging the migration PR, switch the Pages source with: `gh api repos/tylerganter/blog/pages --method PUT --field build_type=workflow`. Build artifacts (`_site/`, `docs/`) are gitignored and never committed.
