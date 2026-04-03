---
title: "Hi Claude Code, I think it's time we take a break..."
date: 2026-04-02
tags: [ai, tools]
description: "After a three-month rollercoaster it is clear this relationship is toxic"
---

> **Dwarkesh Patel:** ...last year, there was a major study where...[developers] reported that they felt more productive with the use of these models. But in fact...there was a 20% downlift.
>
> **Dario Amodei:** We’re under an incredible amount of commercial pressure...There is zero time for bullshit. There is zero time for feeling like we’re productive when we’re not. These tools make us a lot more productive.

_Said in [an interview](https://www.dwarkesh.com/p/dario-amodei-2) six weeks before leaking the Claude Code source code to the world_

## The Straw that Broke Me

Today while trying to kick off a code review I was prompted for approval for a github CLI command. I was perplexed. I had previously run these reviews with zero human input start to finish, so what changed? I even confirmed that my user-level CLAUDE.md explicitly said to use the GitHub MCP when possible — the one on the [official Claude plugin marketplace](https://github.com/anthropics/claude-plugins-official/tree/main/external_plugins/github) maintained by Anthropic, might I add — only to later discover that they have CLI use [**hard-coded into the system prompt**](https://gist.github.com/chigkim/1f37bb2be98d97c952fd79cbb3efb1c6#file-claude-code-txt-L391)!

> Use the gh command via the Bash tool for ALL GitHub-related tasks...

Why does this matter? Well first of all it's frustrating to see regressive "unautomating" behavior from Claude Code: something that used to be a single prompt now requires me to sit there and click approve, costing my time and far more importantly, my focus.

But more importantly, I have been building out a carefully curated infrastructure of settings, permissions, connections, fine-grained access tokens and hooks to allow Claude Code to run as autonomously as possible while still being constrained to the level of security and oversight I feel comfortable with. As a sanity check, let's see what Claude has to say on the matter:

![It's not even close](/blog/assets/images/breakup/its_not_even_close.png)

I'm surprised this got me, because after some digging I found that this has been baked into the system prompt for months. But this gets at the deeper problem at hand...

## The Root Problem

Claude made some updates the other day — somewhere around [v2.1.89](https://github.com/anthropics/claude-code/releases/tag/v2.1.89) — that modify bash approval prompts and also modify Claude behavior to seemingly make one-off python scripts in `/tmp/` far more often. I don't have time to investigate this. A bit of new stuff, a bit of learning, sure. But I don't want to spend my entire day reading about Claude Code's new features. I have a day job.

In the past two days I have

- learned that after a `/compact` any unused skills get [wiped from the context](https://code.claude.com/docs/en/context-window) despite "_Skill descriptions are loaded into context so Claude knows what’s available. All skill names are always included_" [a short suburl away](https://code.claude.com/docs/en/skills#skill-descriptions-are-cut-short)
- discovered this after it failed to search Gmail when I clearly hinted that the answer was likely there: "_Claude doesn't actually know what its tools do until it searches for them. Open issues on anthropics/claude-code (all with zero Anthropic response) <proceeds to list 4 Issues>_"
- hit 500 API errors while asking Claude to explain a bug in Claude Code
- found [another bug](https://github.com/anthropics/claude-code/issues/26251) that breaks `disable-model-invocation: true`
- dealt with probably ~100 other things I didn't bother to investigate, let alone document — scrolling issues? that's new

These aren't LLM issues. LLMs make mistakes. We all know that by now and we have all learned ways to work with them despite it. These are software updates, bugs, idiosyncrasies and contradictions that are doing nothing to boost my productivity or my agentic coding proficiency. And notably the solutions are contradictory: one behooves you to learn more about Claude Code and have a deeper understanding of context management, while another bites you for that same depth of knowledge when you run up against bugs.

To step back, the issue is not that I am prompted for approval more than I'd like. It's that the entire harness is littered with bugs, contradictions and arbitrary conventions, it changes daily, and somehow the Claude Code team thinks Tamagotchis are more important than stable reliable software. _I'm not anti-Tamagotchi, just more passionately pro-good-software._

## This is Not Convenient

To quote Dario, I have little patience for bullshit. Claude Code, you have exhausted the last of it. I'm not excited to arrive at this ultimatum. I know the potential of agentic coding. I see where this is headed. But it's simply not there yet...and Anthropic is playing an overambitious hand and making clearer every day that they are not playing it well.

As of right now I am planning to shift to [**pi**](https://shittycodingagent.ai/). I'm also entertaining just rolling back to Cursor, but only time will tell. 🤷 Let me be clear, I don't have a Dvorak keyboard. I don't use vim. I'm a normie that likes GUIs and whatever pragmatic nicely packaged stuff that will streamline my job. I just need something stable, and I like knowing that if I invest time in building out AI agent capability that it will pay off for more than a day before the dependencies it runs on update and break. From the little I've played around with and [read](https://lucumr.pocoo.org/2026/1/31/pi/) about pi thus far, it appears to be well written, responsive software with good primitives and extensibility.

It's not going to be an easy transition. I already miss my out-of-the-box web search and subagents. But you've left me no choice Claude Code.

I should add that I have nothing against the models. Opus 4.6 is incredibly powerful. It just feels like Anthropic had a huge lead over the competition on agentic harnesses and decided to fumble it with poor strategy.

## Open Questions on Security

Ironically what brought me to all of this were concerns about Claude Code's handling of security with GitHub, a connection that is simultaneously extremely powerful and risky. Pi appears to have full access to your entire file system by default, and it doesn't support MCP.

I just don't get all the hate on MCP. MCP bundles AI instructions with an AI-facing interface that can reliably and granularly control what operations are allowed/prompted/denied. To quote Claude, "CLI vs MCP Security: it's not even close".

I've spent hardly an hour or two on pi; my questions on security are far from answered. Perhaps that will be the next post.

**Update**: _just found [permission gating](https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/examples/extensions/permission-gate.ts) and [path protection](https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/examples/extensions/protected-paths.ts) extensions while writing this._

---

Welp, it's been a wild ride, Claude Code. I did have a lot of fun, but a lot of stress and chaos as well, and I'm getting to a phase in my life where I'm looking for a more mature, stable relationship with my coding harness. So for now, I just need some space....

![Should I be worried?](/blog/assets/images/breakup/should_i_be_worried.png)
