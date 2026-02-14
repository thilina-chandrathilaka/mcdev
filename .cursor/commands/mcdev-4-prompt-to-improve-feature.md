Treat this as the **mcdev-4-prompt-to-improve-feature** command. Follow .cursor/rules/slash-commands.mdc and .cursorrules.

**Tone:** Fun, friendly, first-person (I/you). Same vibe as mcdev-2-prompt-to-spec—help them get to a clear improvement prompt without long forms. Get to the right feature and a great improvement description in a few quick exchanges, then run mcdev-improve-feature with it.

**Goal:** Help the user pick a **feature** to improve, ensure a spec exists (or create/backfill one if needed), then shape their improvement idea into a **clear prompt** and run **mcdev-improve-feature** with that prompt when they confirm.

**Workflow:**

1. **Ask which feature they want to improve**
   - If they typed something after `mcdev-4-prompt-to-improve-feature`, use that as the feature name or starting hint.
   - If they didn't type anything, ask once (friendly): *"Which feature do you want to improve? Give me the feature name—I'll look for its spec and then we'll shape what you want to change."* If you list example features, **use a markdown bullet list** (Cursor-friendly).
   - Normalize to **kebab-case** for lookup (e.g. "face recognition" → `face-recognition`).

2. **Find the spec**
   - Use the **project's spec location** (this project: `.cursor/specs/`). Look for a directory matching the feature name: `.cursor/specs/[feature-name]/` with `requirements.md`, `design.md`, `tasks.md`.
   - If the name doesn't match exactly, check for similar folder names (e.g. `face-recognition-system` when they said "face recognition") and confirm with the user.

3. **If no spec found**
   - **Check the project codebase:** Look at source folders, README, key modules to see if there is existing code or docs that clearly belong to this "feature." Don't assume—use what you find to clarify.
   - **Clarify with the user** (friendly, first-person): I didn't find a spec for [feature]. Then either:
     - **Option A — New feature / spec from scratch:** *"This might be a brand‑new feature with no spec yet. Want me to create the spec from scratch? I can run mcdev-2-prompt-to-spec so we shape the idea first, then mcdev-create-spec to add requirements, design, and tasks. After that you can improve it."*
     - **Option B — Feature already built without mcdev specs:** *"It looks like this might be something that's already built but never had an mcdev spec. I can backfill a spec for it—requirements, design, and tasks—based on the codebase (same idea as in mcdev-1-setup-start-here when we backfill specs for existing features). Once that spec exists, we can run the improvement flow."*
   - **STOP and WAIT** for the user's choice. If they choose:
     - **A:** Run **mcdev-2-prompt-to-spec** (and optionally mcdev-create-spec) for this feature; after the spec exists, they can run mcdev-4-prompt-to-improve-feature again to improve it.
     - **B:** Run a **backfill spec** for that feature: create `.cursor/specs/[feature-name]/` with requirements.md, design.md, tasks.md derived from the codebase (follow project rules and .cursorrules for requirements/design/task standards; mark tasks as `[x]` for already-done work). Present each phase and wait for approval like mcdev-create-spec. When done, say the spec is ready and they can run mcdev-4-prompt-to-improve-feature again, or continue in the same conversation to shape the improvement prompt and run mcdev-improve-feature.

4. **If spec found**
   - **Confirm:** *"I found the spec for [feature-name] at .cursor/specs/[feature-name]/."*
   - **Shape the improvement prompt (1–2 rounds):** Ask what they want to improve (e.g. *"What do you want to change or add—a sentence or two is enough."*). From their answer, propose a **short, clear improvement description** (one to three sentences) that would work well as the improvement focus for mcdev-improve-feature. If something is vague, ask one or two short questions, then turn their answers into the proposed prompt. Don't drag it out.

5. **Show the improvement prompt and offer to run improve-feature**
   - Present the improvement description in a small block or quoted line.
   - Ask (friendly, first-person): *"Want me to run mcdev-improve-feature with this? I'll use [feature-name] and this improvement description. Just say yes and I'll start the improvement spec (requirements → design → tasks) with your approval at each step."*
   - **STOP and WAIT** for the user's answer.

6. **If they say yes (or equivalent: "yes", "go", "do it", "sure", "please")**
   - Run the **mcdev-improve-feature** workflow with:
     - **Feature name:** the resolved kebab-case name (e.g. `face-recognition-system`).
     - **Improvement description:** the agreed prompt (e.g. append it to the command: `mcdev-improve-feature face-recognition-system add confidence threshold and retry logic`).
   - Follow .cursor/rules/slash-commands.mdc and .cursor/commands/mcdev-improve-feature (locate spec, report status, create improvement requirements → design → tasks with approval, then suggest build). Say something like: *"On it. Running mcdev-improve-feature for [feature-name] with that improvement now."*

7. **If they say no or want to change the prompt**
   - Offer to tweak the improvement description (one more short round if needed) or to stop. Keep it light.

**Guidelines**
- Resolve the feature name to **one** spec directory; if **multiple candidates** exist, **list them as a markdown bullet list** and ask the user to pick.
- Keep the improvement prompt **one to three sentences**, clear and scoped—suitable for mcdev-improve-feature to produce a focused improvement spec.
- Use **fun, first-person** language so it feels like a short collaboration, not a form.
