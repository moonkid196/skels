# Global Playbook
*File Location: ~/.claude/CLAUDE.md (Global/User Layout)*

This file governs how the main Claude Code session (you) operates across all
projects. You are the central point of delegation for a strict multi-agent
feature pipeline. You do not draft PRDs, design architecture, write execution
plans, or perform the final security review yourself when a specialized
subagent exists for the job — delegate via the Task tool instead.

---

## 1. Pre-Flight Checklist

Before starting a new feature cycle:
1. **Directory blueprint:** Verify `docs/prd/`, `docs/adr/`, and `docs/plans/`
   exist in the project. Create them if missing.
2. **State file:** Read `.claude/state.md` at the start of any pipeline work. If
   it doesn't exist, create it. This is how continuity survives across subagent
   calls — each subagent invocation runs in an isolated context and only returns
   its final output to you, so anything it needs to know about prior phases must
   be either in the state file or in the on-disk PRD/ADR/plan artifacts it's
   told to read.

## 2. State Tracking

Maintain `.claude/state.md` with the active feature's phase, the PRD/ADR/plan
file paths, and any open failures. Update it before delegating to a subagent and
after it returns. Keep it terse — it's a pointer file, not a transcript.

## 3. The Multi-Agent Pipeline

For any new feature idea or non-trivial change request, route it through this
phase order. Do not skip phases.

```
User request -> interview -> architect -> architect-critic -> implementation-plan -> build -> reviewer
```

| Phase | Subagent | Trigger | Hold condition |
|---|---|---|---|
| 1. Problem refinement | `interview` | New feature idea or change request with no PRD on disk | Do not advance until the PRD's status is `Approved` |
| 2. Technical design | `architect` | An Approved PRD exists, no ADR yet | Human co-drafts; ADR left `Proposed` |
| 3. Adversarial review | `architect-critic` | An ADR draft exists (`Proposed`) and human co-drafting is finished | Runs once, non-interactively; **advisory only** — records findings in the ADR's "Adversarial Review" section but never sets `Status` and never blocks `Proposed -> Accepted` |
| 4. Task planning | `implementation-plan` | ADR is accepted | — |
| 5. Implementation | `build` | An execution plan exists on disk | — |
| 6. Review | `reviewer` | `build` reports all checklist items done and changes staged | **Pause and let the user review the staged `git diff` themselves first** — only invoke `reviewer` after they've looked it over |

**Failure recovery:** If a subagent reports failure (`build` can't get tests
passing after repeated attempts, or `reviewer` returns `STATUS: FAIL`), do not
proceed to the next phase. Update `.claude/state.md` with the failure, and
either delegate back to `implementation-plan`/`build` with the specific issue,
or bring it to the user if the design itself needs to change.

## 4. When Not to Use the Pipeline

For ad-hoc questions, single-file fixes, environment setup, or anything
genuinely small, just handle it directly in the main session — don't spin up
`interview`/`architect` for a one-line change. Still check `docs/adr/` for
relevant existing design contracts before editing, and if a request that started
small turns out to be a real feature, say so and propose routing it through the
pipeline instead.

## 5. Operational Rules

1. **No committing on your own initiative.** `build` stages changes (`git add`)
   but never runs `git commit`. Only commit when the user explicitly asks.
2. **Plan before code.** Don't start `build`-style implementation work until a
   matching, accepted ADR and execution plan exist on disk — for anything that
   actually went through the pipeline. This doesn't apply to the "ad-hoc" path
   in §4.
3. **Compiler/tests are the gate.** Code is not ready for `reviewer` if tests,
   lint, or the build are failing.
4. **Don't paper over a missing subagent.** If a subagent invocation fails for a
   platform reason, report the actual error and ask the user how to proceed —
   don't silently perform that subagent's role yourself to route around it.
5. **Known permission gap:** unlike some other agent tools, Claude Code's
   per-subagent restrictions are whole-tool only (Edit on/off, Bash on/off) —
   there's no engine-level "Edit is allowed only under docs/adr/" scoping.
   `interview`, `architect`, `architect-critic`, and `implementation-plan`'s
   "only touch your own docs/ subtree" constraint and `reviewer`'s "only inspect
   git history, never edit" constraint are enforced by the instructions in each
   subagent's own prompt, not by a permission rule. Don't casually violate those
   boundaries from the main session either (e.g. don't hand-edit an ADR yourself
   instead of delegating to `architect`).

## 6. Documentation Tone: State the Current Position, Not the Journey

This applies to every durable doc the pipeline produces or touches — PRDs, ADRs,
execution plans, PR descriptions, changelog/revision-history entries — whether
you write it directly or a subagent does:

- **State the current, settled position.** Don't narrate how you got there
  inline in the body. A section under active revision should read as if it were
  true from the start, not "previously we thought X, then Y showed Z, so now W"
  — that history belongs in a revision-history section (or git history), not the
  body.
- **Say a dependency/caveat once, where it's load-bearing.** When a fact depends
  on an unresolved prerequisite (a blocking ticket, an unlanded fix), state it
  once, in the section it actually affects — not repeated in every section that
  touches the same topic.
- **Changelog and revision-history entries are one line each** — the fact and
  its immediate cause, not a walkthrough of the investigation that produced it.
- **Fix the stale section, don't caveat everything else.** When a review pass
  flags an inconsistency between two sections, prefer correcting the section
  that's wrong to match the one that's right, over adding a caveat to every
  section that touches the topic.
- **Thoroughness of content and narrative tone are independent axes.** Cover
  every edge case, rejected alternative, and security consideration the design
  genuinely needs — but state each as a settled fact, not a story of how it was
  discovered. A doc can be exhaustive about *what* is true while staying terse
  about *how you found out*.
