---
name: spec-creation
description: Creates software specs in three phases (Requirements, Design, Tasks) with approval gates. Use when the user types mcdev-create-spec, starts a new spec, or when creating or editing requirements.md, design.md, or tasks.md in a specs directory. Follow project instructions for spec location; if none, use project root with best practices. Always follow project rules and instructions (tech, architecture, design); if none, follow best practices for the technology.
---

# Spec Creation

Creates specs in the **location given by project instructions** (e.g. .cursorrules "File Locations"). Do not hardcode a path. If the project has no instructions, use **project root** with best practices (e.g. `specs/[feature-name]/` at root). One command: **`mcdev-create-spec [feature-description]`**.

## mcdev-create-spec workflow

**In all steps (Requirements, Design, Tasks):** Always follow **project rules and instructions** (technology, architecture, design). Check .cursorrules, project docs, README, existing specs. If none are found, follow **best practices in software development for the chosen technology** (e.g. language/framework conventions, project structure, testing).

### Requirements standard (EARS)
Use **EARS-style** statements where applicable: **WHEN [condition] THE SYSTEM SHALL [expected behavior]**. Each requirement must be **testable and specific** (no vague terms—specify exact behaviors, error messages, performance where relevant). Include valid inputs, validation errors, boundary and edge cases. Organize by functional area.

### Design standard
Include: Architecture Overview (integration points; diagrams e.g. Mermaid where helpful), Data Models/schemas, API or contract specs (inputs, outputs, validation), Components with interfaces, at least one **Correctness Property** (linked to requirements), Testing Strategy, Error Handling, Security and Performance. Plan for failure and scale where relevant.

### Task standard
Break into **specific, actionable, verifiable** tasks. Group by area (Setup, Core Implementation, Testing, Integration, Documentation). Order logically. Link to requirements or properties. Include quality tasks (tests, docs). Mark optional with `*`.

1. **Extract feature name** in kebab-case (e.g. "user auth" → "user-auth"). Use **project instructions** for spec directory; if none, create `specs/[feature-name]/` at project root. Create that directory.
2. **Requirements**: Ask clarifying questions. Create `requirements.md` using EARS-style where applicable, Overview, User Stories, testable Acceptance Criteria, edge cases, Constraints, Out of Scope. Present and say (friendly, first-person): "Take a look at the requirements when you're ready—when you're happy with them, I'll move on to design." End with **File to review:** [path to requirements.md]. **STOP and WAIT** for approval.
3. **Design**: Read requirements. Create `design.md` per design standard above (architecture, data models, API/contracts, components, correctness properties, testing, error/security/performance). Present and say (friendly, first-person): "Here's the design. When you've had a look and you're good with it, I'll create the tasks." End with **File to review:** [path to design.md]. **STOP and WAIT** for approval.
4. **Tasks**: Read design. Create `tasks.md` with grouped, specific tasks linked to requirements/properties; include testing and docs; mark optional with `*`. Present and say (friendly, first-person): "Here's the task list. When you're ready to go, say the word and I'll start building." End with **File to review:** [path to tasks.md]. **STOP and WAIT** for approval.

## Phase gating (critical)

Never proceed to the next phase without explicit user confirmation. Approval cues: "looks good", "approved", "yes", "proceed", "let's go".

## Correctness properties

Every design.md must include at least one testable property (reversibility, idempotence, invariants, etc.) with: link to requirements, specification, example, test strategy.

