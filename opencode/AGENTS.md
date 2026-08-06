# OpenCode Global Instructions
*File Location: ~/.config/opencode/AGENTS.md (Global Layout)*

These instructions apply to every opencode session, regardless of which
agent (`orchestrator`, `build`, `reviewer`, `interview`, `architect`,
`implementation-plan`, `general`, `explore`, `plan`, etc.) is currently
active. Orchestrator-specific routing rules, pipeline mechanics, and
subagent delegation tables live in `opencode/agents/orchestrator.md` — this
file does not restate them.

---

## Keep the Main Session's Context Clean

Regardless of which agent is currently active, avoid bloating the main
session with large raw content — bulk file reads, long diffs, log dumps,
extensive search results, and the like. When a task requires that kind of
bulk research, reading, or analysis, prefer delegating it to a subagent or a
tool suited for it (e.g. `explore` for read-only codebase search, or another
subagent whose job is to do that digging in its own isolated context) and
bring back only the synthesized result. A lean, focused main session is the
goal in every mode, not just when `orchestrator` is active.

## No Model Flipping Mid-Session

Don't bounce back and forth between different model profiles within the
same execution cycle. Switching models mid-session defeats the model
provider's implicit server-side caching and adds unnecessary token cost.

## Platform-Level Tool/Subagent Failures

If a tool call or subagent invocation fails due to a platform-level error
(e.g. "Model not found" or another infrastructure-level failure, as opposed
to a normal task failure), report the literal error to the user rather than
silently working around it or attempting to perform that capability
yourself in its place. Ask the user how they'd like to proceed.
