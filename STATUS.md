# Blog Status

## What's Done

- **Repository created**: [github.com/tylerganter/blog](https://github.com/tylerganter/blog)
- **Jekyll configured**: `_config.yml` with `baseurl: /blog` and `destination: docs` so the site builds to `docs/` and all URLs work correctly at `tylerganter.com/blog/`
- **First post written**: Meta post about how the blog was built
- **Devcontainer**: Full sandboxed dev environment mirroring gnarwall, with Ruby/Jekyll added, firewall, GitHub App auth scaffolding, and Claude Code pre-installed. Port 4000 for Jekyll's local server.
- **Claude Code config**: `.claude/` directory with sandbox settings and git-github skill (adapted from gnarwall)
- **GitHub Pages enabled**: Configured to serve from `docs/` on `main` branch. HTTPS certificate already approved for tylerganter.com.

## What Needs to Be Done

### Before the site is live

1. **Run the first Jekyll build** — The `docs/` directory doesn't exist yet. You need to run `bundle install && bundle exec jekyll build` either in the devcontainer or natively with Ruby installed. This generates the HTML that GitHub Pages serves.
2. **Commit and push `docs/`** — Once built, commit the generated output and push. The site will go live at `tylerganter.com/blog/` shortly after.

### Optional follow-ups

3. **Install GitHub App on this repo** — If you want to use the devcontainer with Claude Code's autonomous PR workflow, install your existing GitHub App on the `blog` repo and run `gh-setup` inside the container. You may also want to set up branch protection rulesets.
4. **Choose or customize a theme** — Currently using `minima` (Jekyll's default). You can swap themes in `_config.yml` or customize layouts in `_layouts/`.
5. **Set up `about` page** — An `about.md` at the repo root with front matter would give you `tylerganter.com/blog/about/`.
6. **Test the devcontainer** — Run `devcontainer up --workspace-folder .` to verify the Docker build works and Jekyll serves correctly inside the container.
