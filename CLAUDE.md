# Project Context for Claude Code

## Critical Rules

IMPORTANT: **AI Instruction File Maintenance** — For every PR, you MUST do the following for `CLAUDE.md`: (1) Add one helpful sentence that captures a useful insight, convention, or lesson learned from the PR's changes (e.g., a new pattern introduced, a gotcha discovered, or a clarification of existing behavior). (2) Scan `CLAUDE.md` for stale or out-of-date information (e.g., references to renamed directories, removed features, changed commands, or outdated architecture descriptions). If stale content is found, warn the user about what is outdated and where, but do NOT delete or modify the stale content unless the user explicitly asks you to.

## Project Overview

Personal blog built with Jekyll, served via GitHub Pages at `tylerganter.com/blog/`. For local dev commands (Jekyll serve, build, drafts), see [.devcontainer/README.md](.devcontainer/README.md).

### Key Directories
- `/workspace/_posts/` - Published blog posts (Markdown)
- `/workspace/_drafts/` - Unpublished drafts (Markdown)
- `/workspace/_layouts/` - Custom HTML layouts (optional, theme provides defaults)

### Creating a New Post

Posts go in `_posts/` as `YYYY-MM-DD-title-slug.md` with frontmatter: `title`, `date`, `tags`.

## Git & GitHub Workflow

All changes go through **feature branches and pull requests** — never push directly to `main`. The `main` branch is protected with GitHub Rulesets requiring PR approval before merging.

Claude authenticates as a **GitHub App** (`tylerganter-claude-bot[bot]`), which gives it its own identity separate from the repo owner. This means the owner can approve PRs that Claude creates.

For the full workflow (branching, committing, PRs, syncing), see the [github skill](.claude/skills/github/SKILL.md). For authentication setup and the security model, see [GITHUB.md](.devcontainer/GITHUB.md).

<!-- TODO: Define autonomy boundaries — what Claude can do proactively (e.g., commit, push, open PRs on feature branches) vs. what requires asking the user first. -->

## Container Environment

The dev container runs with a **network firewall** that restricts outbound traffic to GitHub, Anthropic, npm/rubygems, and VS Code marketplace only. See [.devcontainer/README.md](.devcontainer/README.md) for container setup and [init-firewall.sh](.devcontainer/init-firewall.sh) for the full allowlist.

## Deployment

The site is deployed via **GitHub Actions** (`.github/workflows/pages.yml`) — on every push to `main`, the workflow builds with Jekyll and deploys via `actions/deploy-pages`. Build artifacts (`_site/`, `docs/`) are gitignored and never committed.

The custom domain `tylerganter.com` is configured on the **user site repo** (`tylerganter.github.io`), not this repo. This blog is a GitHub Pages **project site** — it's automatically served at `tylerganter.com/blog/` via `baseurl: "/blog"` in `_config.yml`, with no custom domain setting needed on this repo.

## Lessons Learned

- VS Code/Cursor inject a credential helper into `/etc/gitconfig` inside devcontainers; `GIT_CONFIG_NOSYSTEM=1` in `containerEnv` prevents this from overriding `gh auth git-credential`.
- Keep `CLAUDE.md` lean — it's always in context, so move detailed commands and setup instructions to dedicated docs and cross-reference instead.
- The `ruby/setup-ruby` action requires an explicit `ruby-version` or a `.ruby-version` file — without either, the workflow fails immediately.
- All Claude Code skills live under `.claude/skills/` — avoid placing them in alternative directories like `.agents/` to keep tool discovery consistent.
- To override Minima's gem-based theme, place files with matching paths in the project root (`_layouts/`, `_includes/`, `_sass/`, `assets/main.scss`) — Jekyll prioritizes project files over the gem's bundled versions.
