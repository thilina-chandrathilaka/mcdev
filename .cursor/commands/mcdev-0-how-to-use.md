Treat this as the **mcdev-0-how-to-use** command. Follow .cursor/rules/slash-commands.mdc and .cursorrules.

When the user runs this command, present the following in a **fun, friendly tone**. Do not run any workflow.

---

## What to show

### Title (big / prominent)
**Welcome to mcdev**

### Intro (normal text, warm and personal)
Why **"mc"**? It's short for **malchan**.

Why **malchan**? It's a mix of my mom's and dad's names. I've always wanted to build things that help people solve real problems. This is the start of that—helping both vibe-coders and real-coders get the most out of AI coding tools.

You can read the full story here: [malchan.com/dev](https://malchan.com/dev)

---

### How to use (mcdev-0-how-to-use)
You just ran this. It's your go-to reminder for what all the mcdev commands do—a little memory refresher whenever you need it.

---

### The commands (keep it simple and friendly — order: 0 → 1 → 2 → 3 → 4)

- **How to use (mcdev-0-how-to-use)**  
  You just ran this. Your go-to reminder for what all the mcdev commands do.

- **Setup — start here (mcdev-1-setup-start-here)**  
  Run this once on a folder. If the folder is empty, the agent will ask what tech you want (or pick for you) and create .mcdev-steering with **all** steering files plus cursor rules. If you already have code, the agent can add .mcdev-steering with all steering files and backfill specs for what's already built, then show you the rest of these commands. Highly recommended so I can work with you properly.

- **Prompt to spec (mcdev-2-prompt-to-spec)**  
  Not sure how to phrase your idea? I'll chat with you for a message or two, shape it into a clear prompt that works great for specs, then offer to create the spec from it. Say yes and I run mcdev-create-spec with that prompt.

- **Spec-build (mcdev-3-build [feature-name])**  
  You give the name of a spec; the agent runs the tasks, runs tests, and tells you what was built and where. Simple as that.

- **Prompt to improve (mcdev-4-prompt-to-improve-feature)**  
  Not sure which feature or how to phrase the improvement? I'll ask which feature, find (or create/backfill) the spec, shape your improvement into a clear prompt, then run mcdev-improve-feature with it when you say yes.

- **Update .mcdev-steering (mcdev-update-steering)**  
  Run anytime to refresh **all** files in .mcdev-steering from your current project (never a partial update). I also run this automatically after each build so everything stays in sync.

- **Spec-creation (mcdev-create-spec [feature description])**  
  You describe a feature; the agent writes requirements, then design, then a step-by-step task list. You get to approve after each part. Nice and structured.

- **Spec-improve (mcdev-improve-feature [feature-name])**  
  You pick a spec and say what you want to improve. The agent drafts a small improvement (requirements, design, tasks) with your approval at each step. When you're happy, you can run it; when it's done, I merge it into the original spec and archive the improvement. One source of truth, no mess.

**Mention:** When your project has a setup (e.g. .cursorrules, .mcdev-steering), I follow it. If there's no setup, I use **best practices in software development** for the tech you're using.

---

**When listing or showing commands to the user:** Use **square brackets** for placeholders, e.g. `mcdev-2-prompt-to-spec`, `mcdev-create-spec [feature description]`, `mcdev-3-build [feature-name]`, `mcdev-4-prompt-to-improve-feature`, `mcdev-improve-feature [feature-name]`. Do **not** use angle brackets (&lt; &gt;) — use only [ ] for placeholders.
