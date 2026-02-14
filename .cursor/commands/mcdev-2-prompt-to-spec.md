Treat this as the **mcdev-2-prompt-to-spec** command. Follow .cursor/rules/slash-commands.mdc and .cursorrules.

**Tone:** Fun, friendly, first-person (I/you). Sound like a person who's excited to help them nail the right prompt—no interrogation, no long forms. Get to a great prompt in one or two quick back-and-forths, then wow them with a prompt that really matches their idea.

**Goal:** Help the user turn their idea into a **clear, effective prompt** that works great with mcdev-create-spec—not a novel, not a single word. Then offer to run spec-creation with that prompt; if they say yes, run the full mcdev-create-spec workflow with it.

**Workflow:**

1. **Start from their idea**
   - If they typed something after `mcdev-2-prompt-to-spec`, use that as the starting point.
   - If they didn't type anything, ask once: *"What do you want to build? Just a sentence or two—I'll help turn it into a prompt that works really well for creating the spec."* If you give examples (e.g. "a dashboard", "login with Google"), **present them as a markdown bullet list** so they render clearly in Cursor.

2. **Shape the prompt (1–2 rounds max)**
   - From what they said, propose a **short, clear feature description** (one to three sentences) that:
     - Captures the main idea and scope.
     - Is specific enough for a good spec (who/what/outcome or key behavior).
     - Isn't a wall of text and isn't just one word.
   - If their idea is already clear and well-scoped, you can go straight to the proposed prompt.
   - If something's fuzzy (e.g. "a dashboard" — for whom? what on it?), ask **one or two** short, focused questions (e.g. *"Who's the main user, and what's the one thing they need to see or do first?"*), then turn their answers into the proposed prompt.
   - **Don't drag it out.** After at most one or two exchanges, present the prompt. Avoid long checklists or repeated "anything else?" so the user doesn't get frustrated.

3. **Show the prompt and wow them**
   - Present the prompt in a small block or quoted line so it's easy to read.
   - Use warm, first-person language: e.g. *"Here's a prompt that I think really captures what you want…"* or *"I've turned that into something that should work great for the spec…"*
   - Make it obvious that the prompt **matches their idea** and is ready to feed into spec-creation.

4. **Offer to create the spec**
   - Ask (friendly, first-person): *"Want me to create the spec from this? Just say yes and I'll run mcdev-create-spec with this prompt."*
   - **STOP and WAIT** for the user's answer.

5. **If they say yes (or equivalent: "yes", "go", "do it", "sure", "please")**
   - Run the **mcdev-create-spec** workflow using the agreed prompt as the feature description (see .cursor/rules/slash-commands.mdc and .cursor/commands/mcdev-create-spec.md). Derive the kebab-case feature name from the prompt, create the spec directory per project instructions, then run Requirements → Design → Tasks with approval after each phase.
   - You can say something like: *"On it. Creating the spec from that prompt now."* Then proceed with spec-creation.

6. **If they say no or want to change the prompt**
   - Offer to tweak the prompt (one more short round if needed) or to stop. Keep it light and low-pressure.

**Guidelines**
- Aim for a prompt that's **one to three sentences**, clear and scoped—the kind of thing that makes mcdev-create-spec produce a solid spec.
- Prefer **one or two** quick exchanges; only ask more if the idea is genuinely vague and one question isn't enough.
- Use **fun, first-person** language throughout so it feels like a short, friendly collaboration, not a form.
