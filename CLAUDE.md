# Project Context for Claude Code

## Critical Rules

IMPORTANT: **AI Instruction File Maintenance** — For every PR, you MUST do the following for `CLAUDE.md`: (1) Add one helpful sentence that captures a useful insight, convention, or lesson learned from the PR's changes (e.g., a new pattern introduced, a gotcha discovered, or a clarification of existing behavior). (2) Scan `CLAUDE.md` for stale or out-of-date information (e.g., references to renamed directories, removed features, changed commands, or outdated architecture descriptions). If stale content is found, warn the user about what is outdated and where, but do NOT delete or modify the stale content unless the user explicitly asks you to.

## Development Environment

- **Platform**: macOS with devcontainer CLI (npm install, not VS Code)
- **Container runtime**: Docker via devcontainer CLI
- **Working directory**: `/workspace` (inside container)

## Local Development Server

```bash
bundle exec jekyll serve --baseurl /blog
```

Then visit http://localhost:4000/blog/

To preview drafts:

```bash
bundle exec jekyll serve --baseurl /blog --drafts
```

## Project Overview

Personal blog built with Jekyll, served via GitHub Pages at `tylerganter.com/blog/`.

### Key Directories
- `/workspace/docs/` - Generated site output (served by GitHub Pages)
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

Output goes to `docs/` (configured via `destination` in `_config.yml`).

## Git & GitHub Workflow

All changes go through **feature branches and pull requests** — never push directly to `main`. The `main` branch is protected with GitHub Rulesets requiring PR approval before merging.

Claude authenticates as a **GitHub App** (`tylerganter-claude-bot[bot]`), which gives it its own identity separate from the repo owner. This means the owner can approve PRs that Claude creates.

For the full workflow (branching, committing, PRs, syncing), see the [git-github skill](.claude/skills/git-github/SKILL.md). For authentication setup and the security model, see [GITHUB.md](.devcontainer/GITHUB.md).

<!-- TODO: Define autonomy boundaries — what Claude can do proactively (e.g., commit, push, open PRs on feature branches) vs. what requires asking the user first. -->

<!-- TODO: Define whether `bundle exec jekyll build` should be run and `docs/` committed as part of every PR, or only on demand. -->

## Lessons Learned

- When installing a GitHub App on a new repo, "Repository access" is under `github.com/settings/installations` (Configure), not the app's edit page.

## Container Environment

The dev container runs with a **network firewall** that restricts outbound traffic to GitHub, Anthropic, npm/rubygems, and VS Code marketplace only. See [.devcontainer/README.md](.devcontainer/README.md) for container setup and [init-firewall.sh](.devcontainer/init-firewall.sh) for the full allowlist.
