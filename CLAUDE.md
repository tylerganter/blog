# Project Context for Claude Code

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
