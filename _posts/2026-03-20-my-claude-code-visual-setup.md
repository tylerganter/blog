---
title: "My Current Claude Code Visual Setup"
date: 2026-03-20
tags: [ai, tools]
description: "Ghostty splits, color-coded terminals, matched VSCode chrome, and a custom status line — how I've configured Claude Code to feel like a coherent environment rather than a bolted-on tool."
---

*🤖 Disclaimer: This post was written with AI assistance. <span style="color: #b8d4b2;">Text that is predominantly AI-written will appear in this color.</span>*

---

<span style="color: #b8d4b2;">I've been spending a lot of time in Claude Code lately. And somewhere between tweaking terminal colors and wiring up a custom status line, I figured I'd share what I've landed on. The small things compound, and after enough configuration, my terminal actually feels like a coherent environment rather than a tool I'm visiting.</span>

## Ghostty, Full Screen, Splits Everywhere

<span style="color: #b8d4b2;">I run [Ghostty](https://ghostty.org) full screen with splits — multiple Claude Code instances side by side, plus panes to watch files, run servers, or check logs. Splits come and go constantly.</span>

![Ghostty splits](/blog/assets/images/claude-code-visual-config/ghostty-splits.png)

<span style="color: #b8d4b2;">One shortcut I use constantly: `Cmd+Shift+Enter` to zoom into a single pane, then pop back out.</span>

## Color-Coded Terminal Backgrounds

<span style="color: #b8d4b2;">Each project I work in gets its own background color. My obsidian vault gets a subtle green tint, the blog goes deep blue. It's cosmetic, but useful — when I'm context-switching between projects, the color registers before I've consciously parsed the directory path.</span>

This is what I have in my `~/.bash_profile`:

```bash
# Tint terminal background based on directory
_dir_color() {
case "$PWD" in
  */tganter-vault*)    printf '\e]11;#243a2a\a' ;;  # subtle green tint
  */chat-toolkit*)     printf '\e]11;#382440\a' ;;  # magenta
  */tilde-dot-claude*) printf '\e]11;#473830\a' ;;  # anthropic brown
  */tylerganter/blog*) printf '\e]11;#1a1a3a\a' ;;  # personal blog
  *)                   printf '\e]11;#282c33\a' ;;  # ghostty default
esac
}
PROMPT_COMMAND="_dir_color${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
```

<span style="color: #b8d4b2;">The background shifts the moment you `cd` into a project directory.</span>

## Matching VS Code to the Terminal

<span style="color: #b8d4b2;">Every project repo gets a `.vscode/settings.json` that sets the title bar and status bar colors to match Ghostty's background for that project. Commit it so teammates get the same environment automatically.</span>

Here's [the one for this blog](https://github.com/tylerganter/blog/blob/main/.vscode/settings.json) — deep navy/indigo with warm amber text.

![VS Code with matched chrome](/blog/assets/images/claude-code-visual-config/vscode.png)

## Custom Status Line

<span style="color: #b8d4b2;">Claude Code lets you wire up a shell script to drive the status line at the bottom of the terminal. One line in `~/.claude/settings.json`:</span>

```json
{
  "statusLineCommand": "~/.claude/statusline-command.sh"
}
```

<span style="color: #b8d4b2;">My script ([statusline-command.sh](https://github.com/tylerganter/blog/blob/main/assets/statusline-command.sh)) shows three things: the model name, a visual context window usage bar, and the current git branch.</span>

Context usage is the crucial part. Context rot is a real thing. You need to experiment at varying levels of context usage and gain intuition, and while `/context` is useful, it's not the same as an ever-present status bar.

![Claude Code statusline](/blog/assets/images/claude-code-visual-config/statusline.png)

---

I'm still experimenting. I'm not always in the terminal — I still really like the cursor-style editor layout with the AI agent on the right side, which you can get with the Claude Code VS Code extension. But the terminal is at the bleeding edge, and it's the most well-documented and widely adopted interface. The setup is still evolving — hope something here was useful!
