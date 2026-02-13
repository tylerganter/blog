---
title: "How This Blog Was Built"
date: 2026-02-12
tags: [meta, ai]
---

This blog exists because I didn't want to pay for another domain.

I already have [tylerganter.com](https://tylerganter.com) for my portfolio and [gnarwall.org](https://gnarwall.org) for a travel blog. I wanted a place to write about... everything else. AI stuff I'm thinking about, climbing and physical therapy notes, travel, half-baked opinions, whatever. A personal blog in the old-school sense. But I wasn't about to buy a third domain for it.

Turns out, if you're already hosting on GitHub Pages with a custom domain, any new repo you create with Pages enabled just shows up at a subpath. My travel blog already works at `tylerganter.com/gnarwall/`. So this blog lives at `tylerganter.com/blog/`. No DNS changes, no new hosting, no new bills. Just a new repo.

The site itself is built with [Jekyll](https://jekyllrb.com/), which is about as simple as static site generators get. I write a Markdown file, drop it in a folder, build the site, push to GitHub, and it's live. The whole publishing workflow is:

```
write markdown -> jekyll build -> git push
```

That's it. No CMS, no database, no deploy pipeline. The generated HTML lives in a `docs/` directory that GitHub Pages serves directly.

I set this whole thing up with [Claude Code](https://claude.ai/claude-code) in a single session. I described what I wanted, we talked through the options, and it scaffolded the repo -- Jekyll config, devcontainer, the works. The devcontainer mirrors one I already use for gnarwall: a Docker environment with a network firewall, GitHub App authentication so the AI can open PRs that I review, and Claude Code pre-installed. It's a sandboxed setup where I can let the AI work autonomously without worrying about it doing anything catastrophic.

I went with Jekyll over my custom Python static site generator (which powers gnarwall) mainly because Jekyll removes the build-it-yourself friction. For a blog I want to post to casually and often, the less overhead the better. Write Markdown, push, done.

Anyway. First post. The plan is to write about AI, climbing, physical therapy, travel, and whatever else I feel like. No particular theme. No schedule. Just a place to put things.
