---
name: spec-driven-development
description: Routes to spec-creation, spec-execution, spec-improvement, or spec-property-testing. Use when the user types mcdev-0-how-to-use, mcdev-1-setup-start-here, mcdev-update-steering, mcdev-2-prompt-to-spec, mcdev-create-spec, mcdev-3-build, mcdev-4-prompt-to-improve-feature, mcdev-improve-feature, says "implement task", or works in .cursor/specs/ with requirements.md, design.md, or tasks.md.
---

# Spec-Driven Development (index)

Specs live in **`.cursor/specs/[feature-name]/`**. This skill routes to the right focused skill:

| Trigger | Skill to apply |
|---------|----------------|
| **mcdev-0-how-to-use** | See .cursor/commands/mcdev-0-how-to-use.md and slash-commands.mdc: explain all mcdev commands in simple language |
| **mcdev-1-setup-start-here** | See .cursor/rules/slash-commands.mdc and .cursor/commands/mcdev-1-setup-start-here.md: read project, .mcdev-steering/, backfill specs, show commands |
| **mcdev-update-steering** | See .cursor/commands/mcdev-update-steering.md and slash-commands.mdc: refresh all .mcdev-steering files; create if missing; runs after each build |
| **mcdev-2-prompt-to-spec** | See .cursor/commands/mcdev-2-prompt-to-spec.md and slash-commands.mdc: chat to shape idea into a prompt, then offer to run mcdev-create-spec with it |
| **mcdev-4-prompt-to-improve-feature** | See .cursor/commands/mcdev-4-prompt-to-improve-feature.md and slash-commands.mdc: ask which feature; find or backfill spec; shape improvement prompt; run mcdev-improve-feature with it |
| **mcdev-create-spec [feature]** — creating a new spec | [spec-creation](../spec-creation/SKILL.md): Requirements → Design → Tasks with approval gates |
| **mcdev-3-build [feature]** or **implement task X.Y** | [spec-execution](../spec-execution/SKILL.md): Run single task or full build, update tasks.md; supports --improvement [id] and merge/archive |
| **mcdev-improve-feature [feature]** | [spec-improvement](../spec-improvement/SKILL.md): Check spec + build status, create improvement spec, run improvement build, merge into original, archive (one source of truth) |
| **Property test for Property X.Y** / PBT for design | [spec-property-testing](../spec-property-testing/SKILL.md): Write property-based tests from design |

Project rules: .cursorrules, .cursor/rules/spec-driven-development.mdc.
