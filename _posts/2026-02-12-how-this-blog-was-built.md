---
title: "How This Blog Was Built"
date: 2026-02-12
tags: [meta, ai]
description: "Jekyll, GitHub Pages, and a sandboxed devcontainer where an AI agent can commit and open PRs on feature branches — while a human keeps approval authority over main."
---

*🤖 Disclaimer: This post was AI-generated. <span style="color: #b8d4b2;">Text that is predominantly AI-written will appear in this color.</span>*

---

<div style="color: #b8d4b2;" markdown="1">

This blog exists because I didn't want to pay for another domain.

I already have [tylerganter.com](https://tylerganter.com) for my portfolio and [gnarwall.org](https://gnarwall.org) for a travel blog. I wanted a place to write about... everything else. Ideas about AI, climbing and physical therapy notes, travel, opinions I haven't fully stress-tested yet. A personal blog. But I wasn't about to buy a third domain for it.

Turns out, if you're already hosting on GitHub Pages with a custom domain, any new repo you create with Pages enabled just shows up at a subpath. My travel blog already works at `tylerganter.com/gnarwall/`. So this blog lives at `tylerganter.com/blog/`. No DNS changes, no new hosting, no new bills. Just a new repo.

I set this whole thing up with [Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview) in a single session. I described what I wanted, we talked through the options, and it scaffolded the repo — Jekyll config, GitHub Actions workflow, devcontainer, the works. But the interesting part isn't that an AI wrote boilerplate for me. It's the system we built around it — a sandboxed environment where the AI can work autonomously on feature branches, open PRs, and push code, while I retain approval authority over everything that lands on `main`.

Let me walk through the layers.

## Jekyll: The Simplest Possible Stack

The site is built with [Jekyll](https://jekyllrb.com/), which is about as simple as static site generators get. I write a Markdown file, drop it in `_posts/`, push to GitHub, and it's live. The config is minimal — the [Minima](https://github.com/jekyll/minima) theme handles layout, [jekyll-feed](https://github.com/jekyll/jekyll-feed) generates an RSS feed, and [jekyll-seo-tag](https://github.com/jekyll/jekyll-seo-tag) handles meta tags. I don't have a single custom CSS file or JavaScript asset.

I went with Jekyll over my custom Python static site generator (which powers gnarwall) mainly because Jekyll removes the build-it-yourself friction. For a blog I want to post to casually and often, the less overhead the better. Write Markdown, push, done.

## GitHub Actions: Zero-Touch Deployment

There's no manual build step. Every push to `main` triggers a [GitHub Actions workflow](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site#publishing-with-a-custom-github-actions-workflow) that installs Ruby, runs `jekyll build`, and deploys the generated site via `actions/deploy-pages`. The whole pipeline takes about a minute. I don't run `jekyll build` locally, I don't manage a `docs/` directory, and I don't think about deployment at all. Merge a PR, and it's live.

## The Devcontainer: A Sandbox for AI

This is where it gets more interesting. The entire development environment runs inside a [devcontainer](https://containers.dev/) — a Docker container with Ruby, Jekyll, the GitHub CLI, and Claude Code pre-installed. Open the repo in VS Code, click "Reopen in Container," and you're in a fully configured environment.

But the devcontainer isn't just for convenience. It's a security boundary.

### Network Firewall

The container runs an iptables firewall that **drops all outbound traffic by default**, then allowlists only the domains the AI actually needs: GitHub (API, git, and web), Anthropic's API, npm, RubyGems, and the VS Code marketplace. That's it. The firewall even verifies itself on startup — it confirms it *can* reach `api.github.com` and *cannot* reach `example.com`. If the AI tries to phone home somewhere unexpected, the connection gets rejected immediately.

Is this paranoid? Maybe. But if you're going to let an AI agent run with write access to a git repo, I'd rather have one too many guardrails than one too few.

### GitHub App Authentication

Here's the practical problem with giving an AI access to GitHub: if it creates a PR using *your* credentials, GitHub treats it as *your* PR — and you can't approve your own PRs. So the AI needs its own identity.

The solution is a [GitHub App](https://docs.github.com/en/apps/overview). I created one called `tylerganter-claude-bot`, installed it on this repo with read/write access to contents, pull requests, and issues. The app authenticates via a private key stored in the container (gitignored, never committed). When Claude Code pushes a branch or opens a PR, it shows up as authored by the bot — and I can review and approve it like any other contributor's work.

This pairs with GitHub's branch protection rules: `main` requires a PR with at least one approval, and force pushes are blocked. Even if the AI has write access, it physically cannot push directly to `main`. Two layers of defense — the app controls *what the AI can attempt*, and branch protection controls *what can actually happen*.

### Claude Code Skills

The last piece of the devcontainer puzzle is a set of custom [skills](https://docs.anthropic.com/en/docs/claude-code/skills) — Markdown files that give Claude Code domain-specific knowledge about how to work in this repo. There are three:

1. **GitHub workflow** — How to create branches, commit, push, and open PRs using the GitHub App. Includes instructions for token refresh (the app tokens expire hourly) and the branching conventions I want followed.
2. **Writing voice** — A detailed style guide synthesized from my existing writing across Slack, blog posts, published articles, and long-form essays. When I ask Claude to draft something, it writes in my voice rather than generic AI-speak.
3. **Skill creator** — A meta-skill for designing new skills. Patterns, templates, and a scaffold script.

These aren't magic. They're just structured context — the kind of thing you'd put in a contributing guide for a human collaborator, except formatted for an AI to consume. But they make a real difference. The gap between "write a blog post" and "write a blog post in my voice, following my conventions, committed to a feature branch with a PR for my review" is significant, and skills bridge it.

## The Philosophy

What I like about this setup is that it's not clever. Every piece is a well-understood, boring technology: Jekyll, GitHub Pages, GitHub Actions, Docker, iptables. The only unusual part is using Claude Code as a development collaborator — but even that is wrapped in constraints (firewall, separate identity, branch protection) that make the blast radius manageable.

The whole thing optimizes for one thing: **low friction for writing**. I open VS Code, write some Markdown in `_posts/`, and either push it myself or let Claude Code handle the git workflow. No CMS, no database, no deploy pipeline I have to think about. The infrastructure gets out of the way.

Anyway. First post. The plan is to write about AI, climbing, physical therapy, travel, and whatever else I feel like. No particular theme. No schedule. Just a place to put things.

</div>
