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
bundle exec jekyll serve --baseurl /blog
```

Visit http://localhost:4000/blog/

### Native

Requires Ruby and Bundler installed.

```bash
bundle install
bundle exec jekyll serve --baseurl /blog
```

## Publishing

Build the site and push:

```bash
bundle exec jekyll build
git add -A && git commit -m "Add post: title" && git push
```

GitHub Pages serves the `docs/` directory automatically.
