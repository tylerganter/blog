# Blog

Personal blog at [tylerganter.com/blog](https://tylerganter.com/blog/).

## Writing a Post

Create a Markdown file in `_posts/` with the naming convention `YYYY-MM-DD-title-slug.md`:

```markdown
---
title: "My Post Title"
date: 2026-02-12
tags: [ai, climbing]
---

Your content here...
```

## Local Development

### With devcontainer (recommended)

```bash
devcontainer up --workspace-folder .
devcontainer exec --workspace-folder . bash
bundle exec jekyll serve --baseurl /blog --host 0.0.0.0
```

Visit http://localhost:4000/blog/ (trailing slash required).

### Native

Requires Ruby and Bundler installed.

```bash
bundle install
bundle exec jekyll serve --baseurl /blog
```

## Publishing

Changes go through feature branches and pull requests. See the devcontainer [GITHUB.md](.devcontainer/GITHUB.md) for the full workflow.

GitHub Pages serves the `docs/` directory automatically.
