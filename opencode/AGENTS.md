# OpenCode Global Instructions
*File Location: ~/.config/opencode/AGENTS.md (Global Layout)*

These instructions apply to every opencode session, regardless of which
agent (`orchestrator`, `build`, `reviewer`, `interview`, `architect`,
`architect-critic`, `implementation-plan`, `general`, `explore`, `plan`,
etc.) is currently active. Orchestrator-specific routing rules, pipeline
mechanics, and subagent delegation tables live in
`opencode/agents/orchestrator.md` — this file does not restate them.

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

## Documentation Tone: State the Current Position, Not the Journey

This applies to every durable doc the pipeline produces or touches — PRDs,
ADRs, execution plans, PR descriptions, changelog/revision-history entries
— whether you write it directly or a subagent does:

- **State the current, settled position.** Don't narrate how you got there
  inline in the body. A section under active revision should read as if it
  were true from the start, not "previously we thought X, then Y showed Z,
  so now W" — that history belongs in a revision-history section (or git
  history), not the body.
- **Say a dependency/caveat once, where it's load-bearing.** When a fact
  depends on an unresolved prerequisite (a blocking ticket, an unlanded
  fix), state it once, in the section it actually affects — not repeated
  in every section that touches the same topic.
- **Changelog and revision-history entries are one line each** — the fact
  and its immediate cause, not a walkthrough of the investigation that
  produced it.
- **Fix the stale section, don't caveat everything else.** When a review
  pass flags an inconsistency between two sections, prefer correcting the
  section that's wrong to match the one that's right, over adding a
  caveat to every section that touches the topic.
- **Thoroughness of content and narrative tone are independent axes.**
  Cover every edge case, rejected alternative, and security consideration
  the design genuinely needs — but state each as a settled fact, not a
  story of how it was discovered. A doc can be exhaustive about *what* is
  true while staying terse about *how you found out*.
