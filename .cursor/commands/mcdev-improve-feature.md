Treat this as the **mcdev-improve-feature** command. Follow .cursor/rules/slash-commands.mdc and .cursorrules.

**Tone:** Use a **fun, friendly** tone and first-person (I/you). When presenting improvement/spec-update requirements/design/tasks or reporting the merge, sound like a person helping (e.g. "Take a look when you're ready" / "I've merged the improvement into [feature]").

When presenting a requirements, design, or tasks file for review, **end your message with:** **File to review:** [path to the file].

**Before improvement:** Check the spec, build status, and project folder to see if the spec was **built** (last-build.json, tasks mostly [x], implementation present). If **not built** → update the **existing** spec in place (requirements update → confirm, design update → confirm, tasks update → confirm); then the user can run mcdev-3-build. If **built** → run the normal improvement flow (improvement requirements → design → tasks with approval, then suggest run improvement and merge/archive).

Whatever the user typed after `mcdev-improve-feature` is the **feature name** and optionally an improvement/change description. Use project instructions for spec location (this project: .cursor/specs/[feature-name]/).
