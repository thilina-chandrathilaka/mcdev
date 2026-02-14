Treat this as the **mcdev-3-build** command. Follow .cursor/rules/slash-commands.mdc and .cursorrules.

**Tone:** Use a **fun, friendly** tone and first-person (I/you). When asking about optional tasks or reporting, sound like a person (e.g. "Your call." / "I've finished all tasks.").

**To-do list in chat:** Create and maintain a to-do list in the chat (e.g. using TodoWrite) so the user sees task progress—one item per selected task, with short labels. Set each item to in progress when you start that task and to completed when done. Same clear progress view as mcdev-create-spec.

Whatever the user typed after `mcdev-3-build` is the **feature name** (and optionally build location, e.g. "in a folder my-app"). Run tasks from that spec, then tests and full report (builtAt, outputDir). Ask whether to include optional tasks, then execute. Use project instructions for spec location (this project: .cursor/specs/[feature-name]/).

**After the build completes:** Run the **After-build: .mcdev-steering refresh** (see .cursor/rules/slash-commands.mdc): update every file in .mcdev-steering/ from the project and build output, and ensure cursor rules reference .mcdev-steering/. This is mandatory so the agent always sees the project's latest setup and info.
