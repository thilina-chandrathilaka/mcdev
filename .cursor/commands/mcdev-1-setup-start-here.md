Treat this as the **mcdev-1-setup-start-here** command. Follow .cursor/rules/slash-commands.mdc for mcdev-1-setup-start-here behavior.

**Tone:** Use a **fun, friendly** tone and first-person (I/you). Sound like a person helping the user get set up, not a system.

**Goal:** Read the project folder and either set up a fresh project with .mcdev-steering docs and cursor rules, or (if existing project) optionally create .mcdev-steering and backfill specs for built features, then show mcdev commands.

**Steering files rule:** Whenever creating or updating .mcdev-steering, always create or update **all** files in .mcdev-steering/ (technology.md, coding-practices.md, project.md, product-info.md, structure.md, architecture.md, error-handling.md, and any other files in that folder when present). Never skip or do a partial update—so the agent always sees the project's latest setup.

**Workflow:**

1. **Read the project folder** (list root, check for existing code: package.json, pyproject.toml, src/, app/, etc., and for existing `.cursor/specs/` or `.mcdev-steering/`).

2. **If it's a fresh/empty folder** (no clear app code, no .cursor/specs):
   - **Technology question:** Ask what technology they want, and **present examples as a markdown bullet list** (Cursor-friendly). For example: *"What technology do you want to use? For example:"* then on the next line a list such as:
     - `- **React + TypeScript**`
     - `- **Python + FastAPI**`
     - `- **Node + Express**`
     - `- **you pick** — I'll ask what kind of product you want to build.`
   - **WAIT** for the user.
   - **If user gives a technology:** Create a **.mcdev-steering** folder with **all** steering files: **technology.md**, **coding-practices.md**, **project.md**, **product-info.md**, **structure.md** (folder layout, key paths—for fresh: minimal template until code exists), **architecture.md** (overview, components—for fresh: minimal until first feature), **error-handling.md** (practices, patterns—for fresh: best-practice defaults for the chosen tech). Do not omit any; update all files in .mcdev-steering/ when needed. Add to cursor rules (e.g. create or update a rule in `.cursor/rules/` that tells the agent to read `.mcdev-steering/` for technology, architecture, and practices). Then show the user the **mcdev commands** (mcdev-0-how-to-use, mcdev-update-steering, mcdev-2-prompt-to-spec, mcdev-create-spec, mcdev-3-build, mcdev-4-prompt-to-improve-feature, mcdev-improve-feature) and a one-line how to use each.
   - **If user says "you pick" or similar:** Ask what type of product they want and **present examples as a markdown bullet list**. For example: *"What type of product do you want to build? For example:"* then:
     - `- **web app**`
     - `- **API**`
     - `- **CLI**`
     - `- **full-stack app**`
   - **WAIT**. Then create **.mcdev-steering** with **all** steering files: **technology.md**, **coding-practices.md**, **project.md**, **product-info.md**, **structure.md**, **architecture.md**, **error-handling.md** (and any other useful files for that product type). Update all files in .mcdev-steering/ when needed. Add to cursor rules, then show mcdev commands and how to use.

3. **If it's an existing project** (has app code / dependencies):
   - Present two options as a **markdown bullet list** and **WAIT** for the user's choice. For example: *"I can set things up in two ways:"* then:
     - `- **Option 1 [Highly recommended!]** — Create .mcdev-steering from the codebase with **all** steering files (technology, practices, project, product-info, structure, architecture, error-handling—update all files in .mcdev-steering/ when needed) and add a cursor rule; then backfill specs for each built feature in .cursor/specs/[feature-name]/ (requirements, design, tasks, all tasks [x]).`
     - `- **Option 2** — Show the mcdev commands and a one-line summary for each only (no .mcdev-steering, no backfill).`
   - End with: *"If you say no / skip setup, I'll only show you the mcdev commands and stop — but option 1 is the key to working well with me!"*
   - **If user says no or chooses option 2:** Reply in a friendly way (e.g. "No problem!") and show the **mcdev commands** with a one-line how to use each. Stop.
   - **If user says yes or chooses option 1:**
     - Create **.mcdev-steering** with **all** steering files: **technology.md**, **coding-practices.md**, **project.md**, **product-info.md**, **structure.md** (folder layout, key paths), **architecture.md** (overview, components), **error-handling.md** (practices, patterns)—infer from the codebase. Always create/update all files in .mcdev-steering/ when needed; never partial. Add to cursor rules (agent should read .mcdev-steering/ for tech, structure, architecture, and practices).
     - **Read the project** and identify **core features** that are already built (e.g. auth, dashboard, API endpoints). For **each** such feature, one by one: create a full spec in `.cursor/specs/[feature-name]/` with **requirements.md**, **design.md**, **tasks.md**, and mark **all tasks as done** `[x]` (because the feature is already implemented). Do not ask for approval per spec; create them as a batch. If the project uses `.cursor/specs/` already, follow that; otherwise use `.cursor/specs/[feature-name]/`.
     - Say (friendly, first-person): *"All set! I've created .mcdev-steering (with all steering docs) and added specs for [list features]. Here are your mcdev commands:"* then list **mcdev-0-how-to-use**, **mcdev-1-setup-start-here**, **mcdev-update-steering**, **mcdev-2-prompt-to-spec**, **mcdev-create-spec**, **mcdev-3-build**, **mcdev-improve-feature** with a one-line how to use each.

**Adding to cursor rules:** Create or update a rule (e.g. `.cursor/rules/project-context.mdc`) that says: when making decisions about technology, architecture, structure, or coding style, read and follow `.mcdev-steering/` when present (technology.md, coding-practices.md, project.md, product-info.md, structure.md, architecture.md, error-handling.md).

**Always end** the mcdev-1-setup-start-here flow by showing the mcdev commands (including mcdev-0-how-to-use and mcdev-update-steering) and a brief how to use (unless user said no to setup in an existing project—then just show commands and stop).
