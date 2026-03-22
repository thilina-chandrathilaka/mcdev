# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

**mcdev** is a spec-driven development toolkit for Cursor. It is not an application — it is a set of Cursor commands, rules, and skills that get installed into a user's project via a shell script. Users describe what they want; the Cursor agent turns it into requirements, design, and tasks, then helps them build.

Install: `curl -fsSL https://raw.githubusercontent.com/malchan-git/mcdev/main/scripts/install-mcdev.sh | MCDEV_REPO=malchan-git/mcdev bash`

## Repository Structure

- **`.cursor/commands/mcdev-*.md`** — Cursor slash-command definitions (the user-facing commands)
- **`.cursor/rules/*.mdc`** — Cursor rules that govern agent behavior (slash-commands, spec-driven-development, project-context)
- **`.cursor/skills/*/SKILL.md`** — Skills for spec creation, execution, improvement, property testing, and the index skill
- **`.cursorrules`** — Canonical mcdev block (delimited by `# --- mcdev (start) ---` / `# --- mcdev (end) ---`) that gets merged into user projects
- **`scripts/install-mcdev.sh`** — Installer that fetches the repo tarball, merges `.cursor/` (add/update, never delete), and merges the `.cursorrules` block

## Key Concepts

- **Spec-driven workflow**: Requirements → Design → Tasks, with explicit user approval ("phase gating") between each step. The agent must never advance without approval.
- **Steering files** (`.mcdev-steering/`): Per-project context files (technology, architecture, coding-practices, etc.) created at setup and auto-refreshed after builds. These are created in the *user's* project, not in this repo.
- **Specs** live in `.cursor/specs/[feature-name]/` with `requirements.md`, `design.md`, `tasks.md`.
- **Improvements** are merged back into the original spec and archived — specs remain the single source of truth.
- **EARS-style requirements** and **Correctness Properties** in design are the spec standards.

## The Eight Commands

| Command | Purpose |
|---------|---------|
| `mcdev-0-how-to-use` | Show all commands |
| `mcdev-1-setup-start-here` | One-time project setup (steering, optional spec backfill) |
| `mcdev-2-prompt-to-spec` | Chat to shape idea → run mcdev-create-spec |
| `mcdev-create-spec` | Create spec: Requirements → Design → Tasks |
| `mcdev-3-build` | Execute tasks from a spec |
| `mcdev-4-prompt-to-improve-feature` | Chat to shape improvement → run mcdev-improve-feature |
| `mcdev-improve-feature` | Create improvement spec, build, merge back, archive |
| `mcdev-update-steering` | Refresh `.mcdev-steering/` from project state |

## Install Script Behavior (`scripts/install-mcdev.sh`)

The installer is idempotent — re-running updates without overwriting user files:
- `.cursor/` directory: rsync (or cp fallback) from repo, adds/updates files, never deletes existing user files
- `.cursorrules`: If the mcdev block markers exist, replaces just that block; otherwise appends. Creates the file if missing.
- Supports private repos via `MCDEV_GITHUB_TOKEN` env var
- Configurable via `MCDEV_REPO`, `MCDEV_BRANCH`, `MCDEV_TARGET_DIR` env vars

## Tone and Style

When writing mcdev command content or agent dialogue: use a **fun, friendly tone** with first-person (I/you). Use markdown bullet points for options/examples in chat. Follow project rules for tech/architecture; fall back to best practices if none exist.
