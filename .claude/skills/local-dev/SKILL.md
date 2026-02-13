---
name: local-dev
description: Local Jekyll development server for the blog. Use when previewing the blog locally, starting/stopping the dev server, building the site, debugging rendering issues, or verifying changes before pushing. Triggers on requests like "run the blog locally," "preview the site," "start the server," "rebuild," or "check if this looks right."
---

# Local Dev

## Starting the Server

```bash
bundle exec jekyll serve --baseurl /blog --host 0.0.0.0
```

Site URL: `http://localhost:4000/blog/` (trailing slash required).

To include draft posts:

```bash
bundle exec jekyll serve --baseurl /blog --host 0.0.0.0 --drafts
```

To run in the background:

```bash
bundle exec jekyll serve --baseurl /blog --host 0.0.0.0 &
```

## Stopping the Server

```bash
pkill -f "jekyll serve"
```

After killing, wait ~2 seconds before restarting to release the port.

## Building Without Serving

To verify the site compiles without errors:

```bash
bundle exec jekyll build --baseurl /blog
```

Output goes to `_site/` (gitignored).

## When to Restart vs. Auto-Regenerate

Jekyll watches for file changes and auto-regenerates. However:

| Change type | Auto-regenerates? |
|---|---|
| Post/draft content (`.md`) | Yes |
| SCSS/CSS files | Yes |
| Layout and include files | Yes |
| `_config.yml` | **No — must restart server** |
| `Gemfile` | **No — must `bundle install` then restart** |

## Verifying Changes

After the server is running, verify pages render correctly:

```bash
# Check homepage
curl -s http://localhost:4000/blog/ | head -15

# Check a specific post
curl -s http://localhost:4000/blog/2026/02/12/how-this-blog-was-built/ | head -15
```

A properly rendered page starts with `<!DOCTYPE html>`. If you see raw HTML content (e.g., `<p>` tags at line 1 without a `<!DOCTYPE>`), the layout is not being applied — check that `_config.yml` has front matter defaults and that the layout files exist in `_layouts/`.

## Gotchas

- **Trailing slash required**: `/blog` returns 404; `/blog/` works. Jekyll uses directory-style URLs.
- **Front matter defaults**: Posts and pages need `layout` specified either in their frontmatter or via `defaults` in `_config.yml`. Without this, pages render as raw HTML with no styling.
- **Port conflicts**: If port 4000 is in use, kill the old process first with `pkill -f "jekyll serve"`.
- **Sass `@import` deprecation warnings**: These are harmless deprecation notices from Dart Sass about `@import` → `@use` migration. They do not affect the build.
- **Browser caching**: After CSS changes, hard-refresh (`Ctrl+Shift+R` / `Cmd+Shift+R`) or use incognito to verify. `curl` bypasses caching entirely and is the most reliable way to verify.
- **Devcontainer port forwarding**: In VS Code, check the Ports tab to ensure port 4000 is forwarded. If the user can't access localhost:4000, this is likely the issue.
