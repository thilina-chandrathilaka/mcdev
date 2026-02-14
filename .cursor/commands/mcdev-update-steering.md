Treat this as the **mcdev-update-steering** command. Follow .cursor/rules/slash-commands.mdc for mcdev-update-steering behavior.

**Tone:** Use a **fun, friendly** tone and first-person (I/you). When reporting, say "I've created" or "I've updated" so it feels like a person talking.

**Goal:** Update all .mcdev-steering files so they reflect the current project. Run this anytime (e.g. after adding dependencies, changing tech, or refactors). If run again later, go through the project and refresh every .mcdev-steering file with the latest.

**Rule:** When this command runs (by user or after a build), always update **all** files in .mcdev-steering/—technology.md, coding-practices.md, project.md, product-info.md, structure.md, architecture.md, error-handling.md, and any other files present in that folder. Never skip or do a partial update so the agent always sees the project's latest setup.

**Workflow:**

1. **Check for .mcdev-steering:** If **.mcdev-steering/** does not exist, create it like mcdev-1-setup-start-here for an existing project: read the codebase and create **all** steering files—**.mcdev-steering/technology.md**, **coding-practices.md**, **project.md**, **product-info.md**, **structure.md**, **architecture.md**, **error-handling.md** (and any other core files you use). Update all files in .mcdev-steering/ when needed. Ensure cursor rules reference .mcdev-steering/. Then report (friendly, first-person): *"I've created .mcdev-steering. You can run mcdev-update-steering anytime to refresh it from the project."*

2. **If .mcdev-steering/ already exists:** Always update **all** files in .mcdev-steering/ when this command runs—never a partial update. Go through the **entire project** (dependencies, config files, source structure, .cursor/specs, recent changes) and update **every** file in .mcdev-steering/ with the latest:
   - **technology.md** — Update stack, versions, tooling, and any new or removed dependencies or scripts.
   - **coding-practices.md** — Update style, testing, structure, and conventions to match current code and patterns.
   - **project.md** — Update goals, scope, architecture summary, and feature list to match current state and specs.
   - **product-info.md** — Update core product details: product name, what the product is (brief description), main value proposition, and high-level feature list (from .cursor/specs and built features). Keep it in sync when building with mcdev commands.
   - **structure.md** — Update project structure: folder layout, key paths, conventions (from current repo layout).
   - **architecture.md** — Update architecture overview, components, data flow, integration points (from current design and code).
   - **error-handling.md** — Update error handling practices and patterns (from current code and specs).
   - Any other files in .mcdev-steering/ (e.g. glossary.md) — Update so they stay accurate.

   Do not ask for approval; apply updates directly. Then report (friendly, first-person): *"I've updated .mcdev-steering. technology.md, coding-practices.md, project.md, product-info.md, structure.md, architecture.md, error-handling.md (and other core files) are now in sync with the project."*

**When to run:** Users can run **mcdev-update-steering** anytime. **When run after a build:** After every mcdev-3-build and after every improvement build (mcdev-improve-feature → run improvement → merge/archive), the agent **must** run this **entire** workflow—update **every** file in .mcdev-steering/ (technology.md, coding-practices.md, project.md, product-info.md, structure.md, architecture.md, error-handling.md, and any other files in that folder), and ensure cursor rules still reference .mcdev-steering/. Do not do a partial update; use this full refresh so the agent always sees the project's latest setup and info. See "After-build: .mcdev-steering refresh" in .cursor/rules/slash-commands.mdc.
