# 👋 mcdev

> **Spec-driven development in Cursor. Describe what you want; the agent turns it into requirements, design, and tasks—then you build.**

## Install

Run this from your **project root** (the folder you open in Cursor):

```bash
curl -fsSL https://raw.githubusercontent.com/thilina-chandrathilaka/mcdev/main/scripts/install-mcdev.sh | MCDEV_REPO=thilina-chandrathilaka/mcdev bash
```

This repo is public, so the one-liner works from any terminal with no token.

## After installing

1. Open your project in Cursor.
2. In chat, type **mcdev-0-how-to-use** and hit enter. That's your memory refresher for all the commands.
3. Run **mcdev-1-setup-start-here** so the agent can add steering (and optionally backfill specs for what you've already built). Then you're set.

---

## The Problem It Solves

Sound familiar?

- That thing that turned your idea into a real spec and then *actually ran* the tasks (requirements, design, tasks, build, update the checklist—the full loop).
- The idea of one spec to rule them all, but still being able to improve it without spawning five conflicting copies.
- Coding in an editor where the AI could both plan *and* execute with you instead of just talking about it.
- Using another bot to wordsmith the *perfect* prompt before pasting it into your coding AI. (We've all been there.)
- Finding that giving agents clear steering (tech, architecture, product, project, structure, error handling) makes your work cleaner.

Or you're brand new to all of this and have no idea where to start. 

> **This is that—just the great stuff.** All of it, in one place.

---

## Why it's awesome

| Awesomeness | What it means |
|--------|----------------|
| **Prompt to spec, prompt to improve** | Not sure how to phrase your idea (or your improvement)? <br>• Use **mcdev-2-prompt-to-spec** and **mcdev-4-prompt-to-improve-feature**. <br>• The agent chats with you, shapes it into a clear prompt, and runs the right command. |
| **You approve every step** | Requirements → design → tasks, with you saying "looks good" at each phase. <br>• The agent never moves on without your approval. No surprise runs. |
| **`.mcdev-steering`** | One setup gives the Cursor agent everything it needs: tech, architecture, product, project, structure, error handling. <br>• The agent reads it and follows it. No more repeating yourself. |
| **New project or existing code** | Same workflow. <br>• Empty folder? The agent sets up steering (and can pick tech for you). <br>• Already have code? Add steering and backfill specs for what you've built. |
| **Specs stay the single source of truth** | When you run an improvement (mcdev-improve-feature), the improvement is merged back into the original spec and archived. <br>• Your main spec is always up to date. <br>• No drift, no duplicate truths. |
| **Steering stays in sync** | After every build you run with mcdev, `.mcdev-steering` is refreshed from your project. <br>• The agent's context never goes stale. |
| **Your project stays in charge** | mcdev follows your project rules (tech, architecture, design). <br>• No rules yet? The agent uses best practices for your stack. |

---

## What you get

Once mcdev is in your project, Cursor understands a small set of **slash-style commands** you can type in chat. They give you:

- **Structured specs** — Requirements → design → tasks, with you approving each step.
- **Builds from specs** — The agent runs the task list, runs tests, and reports what was built and where.
- **Improvements that stay tidy** — Improve a feature via a small improvement spec; when it's done, it's merged into the original and archived. One source of truth.

Your project stays in charge: mcdev follows your **project rules** (tech, architecture, design). If you don't have any yet, the agent uses **best practices** for your stack.

---

## Commands

| Command | What it does |
|--------------|----------------|
| **/mcdev-0-how-to-use** | Your go-to reminder. Run this anytime to see what all the mcdev commands do. |
| **/mcdev-1-setup-start-here** | Run once on a folder.<br>• Empty project? <br>The agent asks what tech you want (or picks for you) and creates steering files.<br>• Already have code? <br>It can add steering and backfill specs for what you've built, then show you the rest. *Highly recommended* so the agent can work with you properly. |
| **/mcdev-2-prompt-to-spec** | Not sure how to phrase your idea?<br>• Chat for a message or two; the agent shapes it into a clear prompt and offers to create the spec.<br>• Say yes and it runs mcdev-create-spec with that. |
| **/mcdev-3-build** `[feature-name]` | You give the name of a spec; the agent runs the tasks, runs tests, and tells you what was built and where. |
| **/mcdev-4-prompt-to-improve-feature** | Not sure which feature or how to phrase the improvement?<br>• The agent asks which feature, finds (or backfills) the spec, shapes your improvement into a prompt, then runs mcdev-improve-feature when you say yes. |
| **/mcdev-create-spec** `[description]` | You describe a feature; the agent writes requirements, then design, then a step-by-step task list. You approve after each part. |
| **/mcdev-improve-feature** `[feature-name]` | You pick a spec and say what you want to improve.<br>• The agent drafts a small improvement (requirements, design, tasks) with your approval at each step.<br>• When you run it and it's done, the improvement is merged into the original spec and archived. One source of truth. |
| **/mcdev-update-steering** | Refreshes all files in `.mcdev-steering` from your current project.<br>• Run anytime; the agent also runs it automatically after each build. |

Placeholders like `[feature-name]` and `[description]` are just that—replace them with your actual feature name or description.

---

## Updates & Install

Re-run the same command anytime to update—your .cursorrules merges cleanly without overwriting your custom rules:

```bash
curl -fsSL https://raw.githubusercontent.com/thilina-chandrathilaka/mcdev/main/scripts/install-mcdev.sh | MCDEV_REPO=thilina-chandrathilaka/mcdev bash
```

---

## Re-run = update, don't overwrite

You can run the same install command again anytime:

- **`.cursor/`** — All mcdev commands and files are updated from the repo. You get the latest commands and fixes.
- **`.cursorrules`** — The mcdev block is **merged**: if it's already there, it's **replaced** with the latest version; the rest of your `.cursorrules` is left alone. If the block is missing, it's appended.

So you stay up to date without losing your other Cursor rules.

---

## 💡 Why "mc"?

**mc** is short for **malchan**—a mix of my mom's and dad's names. I've always wanted to build things that help people solve real problems. mcdev is part of that: helping both vibe-coders and real-coders get the most out of AI coding tools.

You can read the full story here: **[malchan.com/mcdev](https://malchan.com/mcdev)** 

(Built this with Kimi and /mcdev on Cursor).

---

## What's in this repo

- **`.cursor/`** — Rules, commands, and skills that power the mcdev workflow.
- **`.cursorrules`** — The canonical mcdev block (with delimiters so we can merge it into your file).
- **`scripts/install-mcdev.sh`** — The script that runs when you use the one-liner above.

Add it to your project, open Cursor, and run **mcdev-0-how-to-use** when you want a friendly reminder of what you can do.

---

## License

[MIT](LICENSE) — use it, change it, share it. No strings attached.
