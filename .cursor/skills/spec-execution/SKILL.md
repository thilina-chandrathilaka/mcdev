---
name: spec-execution
description: Executes tasks from an approved spec: single task or full build. Use when the user types mcdev-3-build, says "implement task X.Y", or when implementing or running tasks from a spec. Follow project instructions for spec location; if none, use project root best practices. When implementing: always follow project rules and instructions (tech, architecture, design); if none, follow best practices for the technology.
---

# Spec Execution

Runs tasks from a spec in the **location given by project instructions** (e.g. .cursorrules "File Locations"). Do not hardcode a path. If the project has no instructions, use **project root** (e.g. `specs/[feature-name]/`). Two entry points: **`mcdev-3-build [feature-name]`** and **`implement task X.Y`**.

## Task status in tasks.md

- `[ ]` not started · `[-]` in progress · `[x]` completed · `[ ]*` optional

Always **edit tasks.md** when status changes: before starting `[ ]` → `[-]`, after completing `[-]` → `[x]`.

## Single task: "implement task X.Y"

1. Use **project instructions** to locate the spec directory. Read `requirements.md` and `design.md` first.
2. **Create a to-do list in the chat** (e.g. TodoWrite) with one item for this task; set to in progress when starting, completed when done.
3. In tasks.md change that task `[ ]` → `[-]`. Update to-do: current task in progress.
4. State: "Implementing task X.Y to address Requirements A.B". **Implement** following **project rules and instructions** (tech, architecture, design); if none, follow **best practices for the technology**. Write tests, run tests.
5. In tasks.md change `[-]` → `[x]`. Update to-do: current task completed. Say: "Task X.Y complete. Ready for next task?" **STOP** — do not continue to the next task.

## Full build: mcdev-3-build [feature-name] (optional: --improvement [id])

1. **Resolve spec directory:** If the user specified **--improvement [improvement-id]** (or equivalent), spec directory = `.cursor/specs/[feature-name]/improvements/[improvement-id]/` and **parent** = `.cursor/specs/[feature-name]/`. Otherwise use **project instructions** to locate the spec directory; if none, use project root (e.g. `specs/[feature-name]/`). Ensure requirements.md, design.md, tasks.md exist in the spec directory. For improvement builds, also ensure improvement-meta.json exists. Read all three spec files. **Build location:** user-specified folder, or (for improvement) parent's last-build.json outputDir, or last-build.json in spec dir, or default.
2. **Check last build:** If last-build.json exists (in spec dir for main spec, or in **parent** for improvement), read builtAt and outputDir. If all selected tasks are already complete: run tests only from build location, report (time + location); for **improvement** build also run **merge and archive** (see below), then report. Otherwise proceed with task execution.
3. **Ask the user:** *"Should I complete all tasks (including optional) or skip optional tasks?"* **WAIT** for the user's answer. If skip optional: run only tasks with status `[ ]` (not `[ ]*`). If all: run both `[ ]` and `[ ]*`.
4. **Create a to-do list in the chat** (e.g. TodoWrite): one item per selected task, with short labels (e.g. "Task 1.1: Set up project structure"). Update as you go: set current task to in progress when starting, and to completed when done—same clear progress view as mcdev-create-spec.
5. For each selected task in order: set `[-]` in tasks.md, update to-do (current → in progress), state requirement(s), **implement** (following project rules/instructions for tech, architecture, design; else best practices for the technology), write tests, run tests, set `[x]` in tasks.md, update to-do (current → completed), report. **STOP on first failure** for required tasks. Optional tasks (when included): run but do not stop the build if they fail.
6. When all selected tasks are done: **run the full test suite** from the build output directory. **Write last-build.json** in the spec directory (main) or in the **parent** directory (improvement) with builtAt (ISO 8601) and outputDir. **If this was an improvement build:** run **merge and archive**: merge improvement requirements/design/tasks into the **original** spec (parent); move `improvements/[id]/` to `archive/[id]/`; then run **After-build: .mcdev-steering refresh** (see .cursor/rules/slash-commands.mdc); report (friendly, first-person) "I've merged the improvement into [feature]. Original spec is updated. Archived at .cursor/specs/[feature]/archive/[id]."
7. **Full report:** Feature name, spec path, **built at**, **location**, tasks completed, test run summary. End (friendly, first-person) with: *"Build complete! I've finished all tasks."* or *"Build complete; tests failed: [summary]."*
8. **After every build (main or improvement):** Run the **After-build: .mcdev-steering refresh** (mandatory): if .mcdev-steering/ exists, update **every** file in .mcdev-steering/ (technology.md, coding-practices.md, project.md, product-info.md, structure.md, architecture.md, error-handling.md, and any other files in that folder) from the project and build output; ensure cursor rules still reference .mcdev-steering/. See .cursor/rules/slash-commands.mdc "After-build: .mcdev-steering refresh" and .cursor/commands/mcdev-update-steering.md for the full refresh logic.

**Merge and archive (improvement only):** Read original (parent) requirements.md, design.md, tasks.md and improvement's three files. Merge: append or update requirements, design, and tasks; merge task lists preserving final status ([x]/[ ]). Write merged content to the **original** (parent) files. Move the folder `improvements/[improvement-id]/` to `archive/[improvement-id]/`. See .cursor/specs/README-improvements.md.

## Traceability

- When implementing: "Implementing task X.Y to address Requirements A.B".
- When testing properties: "This validates Property X.Y from the design."

