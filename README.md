# 👋 Welcome to mcdev

**If you loved Kiro** and how it wrote and executed specs (requirements, design, tasks, build and update task file)…  
**If you loved OpenSpec** and how it kept one source of truth while still letting you improve…  
**If you loved Cursor** and how it could plan and execute with you…  
**If you loved using ChatGPT and others** to craft better prompts to feed into Kiro, OpenSpec, or Cursor…  
**If you’ve found** that giving agents clear steering (tech, architecture, product, project, structure, error handling) makes your work cleaner…  
**Or if you’re brand new** to all of this and have no idea where to start… 🌱

**This is that—just the great stuff.** ✨ All of it, in one place.

---

**mcdev** brings **spec-driven development** into Cursor first—sorry Claude and others, you’ll get your turn later; I live in Cursor and love it, so Cursor gets the first slice. 🖤 You describe what you want, the agent turns it into requirements, design, and tasks, then you build from that together. No chaos, no guessing. Just a clear path from idea to shipped feature. 🛤️

**Why it’s awesome:**

- 🗣️ **Prompt to spec, prompt to improve** — Not sure how to phrase your idea (or your improvement)? Use **mcdev-2-prompt-to-spec** and **mcdev-4-prompt-to-improve-feature**. The agent chats with you, shapes it into a clear prompt, and runs the right command. Saves you a ton of head-scratching.
- 📁 **`.mcdev-steering`** — One setup gives the Cursor agent everything it needs: tech, architecture, product, project, structure, error handling. The agent reads it and follows it. No more repeating yourself.
- 📌 **Specs stay the single source of truth** — When you run an improvement (mcdev-improve-feature), the improvement is merged back into the original spec and archived. Your main spec is always up to date. No drift, no duplicate truths.
- 🔄 **Steering stays in sync** — After every build you run with mcdev, `.mcdev-steering` is refreshed from your project. The agent’s context never goes stale.

---

## 💡 Why “mc”?

**mc** is short for **malchan**—a mix of my mom’s and dad’s names. I’ve always wanted to build things that help people solve real problems. mcdev is part of that: helping both vibe-coders and real-coders get the most out of AI coding tools.

You can read the full story here: **[malchan.com/dev](https://malchan.com/dev)** →

---

## 🎁 What you get

Once mcdev is in your project, Cursor understands a small set of **slash-style commands** you can type in chat. They give you:

- 📋 **Structured specs** — Requirements → design → tasks, with you approving each step.
- 🔨 **Builds from specs** — The agent runs the task list, runs tests, and reports what was built and where.
- 🧹 **Improvements that stay tidy** — Improve a feature via a small improvement spec; when it’s done, it’s merged into the original and archived. One source of truth.

Your project stays in charge: mcdev follows your **project rules** (tech, architecture, design). If you don’t have any yet, the agent uses **best practices** for your stack.

---

## 📖 The commands (in a nutshell)

| Command | What it does |
|--------|----------------|
| **mcdev-0-how-to-use** | Your go-to reminder. Run this anytime to see what all the mcdev commands do. |
| **mcdev-1-setup-start-here** | Run once on a folder. Empty project? The agent asks what tech you want (or picks for you) and creates steering files. Already have code? It can add steering and backfill specs for what you’ve built, then show you the rest. *Highly recommended* so the agent can work with you properly. |
| **mcdev-2-prompt-to-spec** | Not sure how to phrase your idea? Chat for a message or two; the agent shapes it into a clear prompt and offers to create the spec. Say yes and it runs mcdev-create-spec with that. |
| **mcdev-create-spec** [description] | You describe a feature; the agent writes requirements, then design, then a step-by-step task list. You approve after each part. |
| **mcdev-3-build** [feature-name] | You give the name of a spec; the agent runs the tasks, runs tests, and tells you what was built and where. |
| **mcdev-4-prompt-to-improve-feature** | Not sure which feature or how to phrase the improvement? The agent asks which feature, finds (or backfills) the spec, shapes your improvement into a prompt, then runs mcdev-improve-feature when you say yes. |
| **mcdev-improve-feature** [feature-name] | You pick a spec and say what you want to improve. The agent drafts a small improvement (requirements, design, tasks) with your approval at each step. When you run it and it’s done, the improvement is merged into the original spec and archived. One source of truth. |
| **mcdev-update-steering** | Refreshes all files in `.mcdev-steering` from your current project. Run anytime; the agent also runs it automatically after each build. |

Placeholders like `[feature-name]` and `[description]` are just that—replace them with your actual feature name or description.

---

## 🚀 Install (one command)

Run this from your **project root** (the folder you open in Cursor):

```bash
curl -fsSL https://raw.githubusercontent.com/thilina-chandrathilaka/mcdev/main/scripts/install-mcdev.sh | MCDEV_REPO=thilina-chandrathilaka/mcdev bash
```

This repo is public, so the one-liner works from any terminal with no token. ✨

---

## ✅ After installing

1. Open your project in Cursor.
2. In chat, type **mcdev-0-how-to-use** and hit enter. That’s your memory refresher for all the commands.
3. Run **mcdev-1-setup-start-here** so the agent can add steering (and optionally backfill specs for what you’ve already built). Then you’re set. 🎉

---

## 🔄 Re-run = update, don’t overwrite

You can run the same install command again anytime:

- **`.cursor/`** — All mcdev commands and files are updated from the repo. You get the latest commands and fixes.
- **`.cursorrules`** — The mcdev block is **merged**: if it’s already there, it’s **replaced** with the latest version; the rest of your `.cursorrules` is left alone. If the block is missing, it’s appended.

So you stay up to date without losing your other Cursor rules. 👍

---

## 📦 What’s in this repo

- **`.cursor/`** — Rules, commands, and skills that power the mcdev workflow.
- **`.cursorrules`** — The canonical mcdev block (with delimiters so we can merge it into your file).
- **`scripts/install-mcdev.sh`** — The script that runs when you use the one-liner above.

That’s it. Add it to your project, open Cursor, and run **mcdev-0-how-to-use** when you want a friendly reminder of what you can do. 💬

---

**License:** [MIT](LICENSE) — use it, change it, share it. No strings attached.
