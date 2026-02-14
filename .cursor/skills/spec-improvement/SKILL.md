---
name: spec-improvement
description: Improves an existing spec via a separate improvement spec (OpenSpec-style). Use when the user types mcdev-improve-feature, asks to run an improvement build, or to merge and archive an improvement.
---

# Spec Improvement (OpenSpec-style)

Before improving, the agent **checks spec, build status, and project folder** to see if the spec was **built**. If **not built** → update the **existing** spec in place (requirements update → confirm, design update → confirm, tasks update → confirm). If **built** → create an improvement spec and run the improvement flow. Improvement specs keep the **original spec as the single source of truth**; flow: **check** → (spec-update path **or** improvement path) → for improvement: improvement requirements (confirm) → improvement design (confirm) → improvement tasks (confirm) → suggest build → run improvement build → **merge into original** → **archive** improvement.

**Reference:** `.cursor/specs/README-improvements.md` (if present) for directory layout, improvement-meta.json, merge, and archive.

**Building and improvement specs:** When creating or updating requirements, design, or tasks, and when **implementing** improvement tasks: always follow **project rules and instructions** (technology, architecture, design). If none are found, follow **best practices in software development for the chosen technology**.

**Phase gating (same as mcdev-create-spec):** Never move to the next phase without explicit user confirmation. After each requirements/design/tasks update or improvement phase → present → WAIT.

## mcdev-improve-feature [feature-name] (optional: improvement description)

1. **Resolve feature and read spec:** Use **project instructions** to locate the spec directory (e.g. `.cursor/specs/[feature-name]/`). Verify `requirements.md`, `design.md`, `tasks.md` exist. Read all three and, if present, `last-build.json` (builtAt, outputDir).
2. **Check project folder:** Determine if the spec was **built**: last-build.json exists with valid outputDir; tasks.md has most or all tasks `[x]`; project folder has implementation (outputDir exists with code, or source clearly matches the feature). If no last-build.json, or outputDir missing/empty, or most tasks still `[ ]` → **spec not built**.
3. **Report and decide:** Report feature name, spec path, task summary (counts of [x], [ ], [ ]*), last build time and location (or "No previous build"). State whether the spec **was built** or **not built**. If **not built** → use **Spec-update path** (below). If **built** → use **Improvement path** (steps 4–9).

### Spec-update path (spec not built)

Update the **existing** spec files in place; no improvement directory. Same phase gating: confirm after each file.

- **A. Improvement focus:** If the user did not give a change description, ask what they want to change or add. **WAIT**.
- **B. Requirements update:** Update `requirements.md` in the spec directory (add/change/remove per user intent; keep EARS-style and structure). Present. Say (friendly): *"Take a look at the updated requirements—when you're happy, I'll move on to the design."* End with **File to review:** [path]. **STOP and WAIT**.
- **C. Design update:** After approval, update `design.md` in the spec directory. Present. Say (friendly): *"Here's the updated design. When you're good with it, I'll update the tasks."* End with **File to review:** [path]. **STOP and WAIT**.
- **D. Tasks update:** After approval, update `tasks.md` in the spec directory. Present. Say (friendly): *"Here's the updated task list. When you're ready, you can run mcdev-3-build to build this feature."* End with **File to review:** [path]. **STOP and WAIT**. Do not create improvements/ or run improvement build.

### Improvement path (spec built)

4. **Improvement focus:** If the user did not give an improvement description in the message, ask what they would like to improve and **present example improvements as a markdown bullet list** (Cursor-friendly). For example: *"What would you like to improve? For example:"* then bullets such as `- **add keyboard shortcuts**` / `- **support decimals**` / `- **refactor state machine**`. **WAIT** for the answer.
5. **Setup improvement directory:**
   - Derive **improvement-id** in kebab-case from the description (e.g. "add keyboard shortcuts" → `add-keyboard-shortcuts`). If an improvement with that id already exists under `improvements/`, append a short timestamp or suffix to keep it unique.
   - Create directory: `.cursor/specs/[feature-name]/improvements/[improvement-id]/`.
   - Create **improvement-meta.json** with `parentFeature`, `improvementId`, `description`, `createdAt` (ISO 8601).
6. **Improvement requirements phase:** Create **requirements.md** only (focused on the improvement; EARS-style where applicable; can state "Extends [feature-name]; this improvement adds: ..." or use delta-style ADDED/MODIFIED/REMOVED). Present the improvement requirements. Say (friendly, first-person): *"Take a look at the improvement requirements when you're ready—when you're happy, I'll move on to the design."* End with **File to review:** [path to file]. **STOP and WAIT** for user approval (e.g. "looks good", "approved", "proceed").
7. **Improvement design phase:** After approval, create **design.md** only (architecture delta, new/updated components, correctness properties if new behavior; can reference the parent design). Present the improvement design. Say (friendly, first-person): *"Here's the improvement design. When you're good with it, I'll create the tasks."* End with **File to review:** [path to design.md]. **STOP and WAIT** for user approval.
8. **Improvement tasks phase:** After approval, create **tasks.md** (specific, verifiable tasks for this improvement only; link to improvement requirements; mark optional with `*`; start numbering from 1.1 or project convention). Present the improvement tasks. Say (friendly, first-person): *"Here are the improvement tasks. When you're ready, say 'approved' or 'run improvement' to build now (or 'run improvement in a folder X'). You can also run later: mcdev-3-build [feature-name] --improvement [improvement-id]."* End with **File to review:** [path to tasks.md]. **STOP and WAIT** for approval or "run improvement".
9. **If user says "run improvement" (or "approved" and then "run improvement"):** Treat as **mcdev-3-build** for the **improvement** spec (see spec-execution SKILL): create and maintain a **to-do list in the chat** (one item per selected task, update in progress/completed as you go). Spec directory = `.cursor/specs/[feature-name]/improvements/[improvement-id]/`. Ask: "Should I complete all tasks (including optional) or skip optional tasks?" **WAIT**. Then run tasks, run tests from the **parent’s build location** (last-build.json’s outputDir or user-specified folder), and when **all selected tasks are done**: run **merge and archive** (see below). Update parent’s last-build.json if build output is the same as parent’s outputDir.
10. **If user only approves** (does not say "run improvement" yet): Tell them they can run the improvement later with: *"mcdev-3-build [feature-name] --improvement [improvement-id]"* or by saying **"run improvement"** in this chat.

## Merge and archive (when improvement build is complete)

1. Read the **original** spec (requirements, design, tasks) and the **improvement** spec (improvements/[id]/).
2. **Merge:** Combine improvement into the original: append or update requirements, design, and tasks; merge task lists and preserve final task status ([x] or [ ]) from the improvement.
3. Write merged content to the **original** files (`.cursor/specs/[feature-name]/requirements.md`, `design.md`, `tasks.md`).
4. **Archive:** Move `improvements/[improvement-id]/` to `archive/[improvement-id]/` (create `archive/` if needed).
5. If build used the parent’s outputDir, update the parent’s **last-build.json** with current timestamp and same outputDir.
6. **After-build: .mcdev-steering refresh:** Run the full refresh (see .cursor/rules/slash-commands.mdc): update every file in .mcdev-steering/ from the project and build output; ensure cursor rules reference .mcdev-steering/. Mandatory so the agent sees the project's latest setup.
7. Report (friendly, first-person): *"I've merged the improvement into [feature-name]. Original spec is updated. Improvement archived at .cursor/specs/[feature-name]/archive/[improvement-id]."*

## mcdev-3-build with --improvement

When the user runs **mcdev-3-build [feature-name] --improvement [improvement-id]** (or equivalent):

- **Spec directory** = `.cursor/specs/[feature-name]/improvements/[improvement-id]/` (not the parent). Verify requirements.md, design.md, tasks.md, improvement-meta.json exist.
- Run the normal **spec-build** workflow (ask optional tasks?, run tasks, run tests, full report). **Build location** = user-specified folder, or **parent’s** last-build.json outputDir (read from `.cursor/specs/[feature-name]/last-build.json`), or default.
- When **all selected improvement tasks are done**: run **merge and archive** as above; then report with built at, location, and "Improvement merged and archived."

## Traceability

- Improvement requirements/design/tasks should reference the parent feature where relevant.
- After merge, the original spec remains the single source of truth; archive is for history only.
