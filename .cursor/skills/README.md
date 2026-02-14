# Cursor skills — Spec-driven development

Skills use Cursor’s standard: **one directory per skill** with **SKILL.md** (frontmatter + instructions). 
## Skills

| Skill | Trigger | Purpose |
|-------|---------|--------|
| **mcdev-0-how-to-use** | `mcdev-0-how-to-use` | Not a skill—see .cursor/commands/mcdev-0-how-to-use.md: explain all mcdev commands in simple language |
| **mcdev-1-setup-start-here** | `mcdev-1-setup-start-here` | Not a skill—see .cursor/commands/mcdev-1-setup-start-here.md and slash-commands.mdc: project setup, .mcdev-steering/, backfill specs, show commands |
| **mcdev-update-steering** | `mcdev-update-steering` | Not a skill—see .cursor/commands/mcdev-update-steering.md: refresh all .mcdev-steering files; create if missing; runs after each build |
| **mcdev-2-prompt-to-spec** | `mcdev-2-prompt-to-spec` | Not a skill—see .cursor/commands/mcdev-2-prompt-to-spec.md: chat to shape idea into a prompt, then offer to run mcdev-create-spec with it |
| **mcdev-4-prompt-to-improve-feature** | `mcdev-4-prompt-to-improve-feature` | Not a skill—see .cursor/commands/mcdev-4-prompt-to-improve-feature.md: ask which feature; find or backfill spec; shape improvement prompt; run mcdev-improve-feature with it |
| **spec-creation** | `mcdev-create-spec`, creating requirements/design/tasks | Requirements → Design → Tasks with phase gating |
| **spec-execution** | `mcdev-3-build`, "implement task X.Y" | Run single task or full build; update tasks.md; supports --improvement and merge/archive |
| **spec-improvement** | `mcdev-improve-feature` | Check spec + build status; create improvement spec; run improvement build; merge into original; archive (one source of truth) |
| **spec-property-testing** | Property test tasks, PBT, "Validates: Property X.Y" | Write property-based tests from design |
| **spec-driven-development** | mcdev-0-how-to-use, mcdev-1-setup-start-here, mcdev-update-steering, mcdev-2-prompt-to-spec, mcdev-create-spec, mcdev-3-build, mcdev-4-prompt-to-improve-feature, mcdev-improve-feature, implement task, .cursor/specs/ | Index: routes to the skills above |

## Layout

```
.cursor/skills/
  spec-creation/SKILL.md
  spec-execution/SKILL.md
  spec-improvement/SKILL.md
  spec-property-testing/SKILL.md
  spec-driven-development/SKILL.md   (index)
```

Specs are stored in **`.cursor/specs/`**. Commands and setup: .cursorrules and .cursor/rules/slash-commands.mdc.
