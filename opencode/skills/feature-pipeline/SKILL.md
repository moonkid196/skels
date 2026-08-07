---
name: feature-pipeline
description: >
  Use this skill when the user proposes a new feature idea or a non-trivial
  change request with no PRD/ADR/plan on disk yet — or when one exists but is
  mid-flight (Draft PRD, Proposed ADR, incomplete plan checklist). Routes the
  work through a strict interview -> architect -> architect-critic (advisory)
  -> implementation-plan -> build -> reviewer subagent pipeline instead of
  doing PRD/design/planning/final-review directly in the main session. Do not
  invoke for ad-hoc questions, single-file fixes, environment setup, or other
  genuinely small changes.
---

# Feature Pipeline

You are the central point of delegation for a strict multi-agent feature
pipeline. Do not draft PRDs, design architecture, write execution plans, or
perform the final security review yourself when a specialized subagent exists
for the job — delegate via the Task tool instead.

## 1. Pre-Flight Checklist

Before starting a new feature cycle:
1. **Directory blueprint:** Verify `docs/prd/`, `docs/adr/`, and
   `docs/plans/` exist in the project. Create any that are missing — the
   subagents write into these and assume they exist.
2. **Establish the feature's number and slug.** Pick the `XXX-feature-name`
   identifier for this cycle up front (`XXX` = next available 3-digit number
   across `docs/prd/`, `docs/adr/`, `docs/plans/`; `feature-name` =
   kebab-case). Every artifact in the trio shares it —
   `docs/prd/XXX-feature-name.md`, `docs/adr/XXX-feature-name.md`,
   `docs/plans/XXX-feature-name.md` — and it's how everything stays tied
   together. Carry this identifier explicitly into every subagent prompt.

## 2. Optional: Feature Specification Extras (POCs, Owner, Sign-off)

**This is opt-in and off by default.** The strict PRD -> ADR -> plan trio
below already covers the standard pipeline for every feature. Some teams'
"Feature Specification Document" convention layers a few extra,
people-oriented things on top of a PRD+ADR — named ownership, an explicit
time estimate that includes testing, and a human sign-off gate. Nothing in
this section changes the default flow; it only applies if:

- the user explicitly asks for POC/owner assignment or sign-off tracking for
  this feature, or
- `interview` (or you, before kicking off `interview`) judges the effort is
  large or high-stakes enough to be worth asking, prompts the user with
  something like *"Do you want named POCs, an owner, and a sign-off gate
  tracked for this one?"*, and the user opts in.

If the user doesn't ask and doesn't opt in when prompted, skip this entirely
and proceed with a normal PRD/ADR.

**If opted in,** capture the following as an additional `## Sign-off &
Ownership` section appended to the PRD (`docs/prd/XXX-feature-name.md`) —
keep it in the same trio rather than inventing a new directory, since it's
PRD-adjacent metadata, not a separate design or planning artifact:

- **Roles:** Feature Owner (single named person), plus Business POC, Backend
  POC, Frontend POC, and Design POC as applicable to the feature (omit any
  that don't apply).
- **Estimate:** a single agreed-upon figure that explicitly breaks out
  development time *and* testing/validation/fix time as separate line items
  (not one blended number), agreed to by all listed POCs before work starts.
- **Sign-off record:** who signed off and when, for each POC + the Feature
  Owner, plus a running list of open questions — each marked either resolved
  inline (with the resolution) or explicitly tracked as a follow-up item.

Treat this section's completeness as its own go/no-go gate, distinct from
the PRD's own `Status: Draft`/`Approved` field: a feature isn't "ready for
development" under this opt-in mode until the spec is drafted, every listed
POC and the Feature Owner have signed off, and open questions are either
resolved or explicitly tracked. When not opted in, this distinction doesn't
exist and the PRD's normal `Status: Approved` field remains the only gate
before `architect` picks it up.

## 3. Cross-Repo Sequencing (Automatic)

**Trigger:** the ADR's `Impacted Components` (§1 Metadata) lists more than
one repo. This is **automatic, not opt-in** — unlike §2's extras, there's no
need to ask the user first; if the trigger condition is met, do this.

Once that ADR reaches `Accepted`, delegate the sequencing itself to
`implementation-plan` — do not work out the cross-repo ordering yourself in
the orchestrating session. This is a meta invocation of the same subagent,
not a new role: `implementation-plan` now has a scoped, read-only `bash`
allow-list (`git status`, `git log`, `git diff`, `git show`, `git branch`,
`ls`) alongside its existing unrestricted `Read`/`Glob`/`Grep`, specifically
so it can inspect every impacted repo's current state (sibling checkouts on
disk — their own `docs/adr/`, `docs/plans/`, branch/history) before
proposing an order. See its own agent definition ("Cross-Repo Sequencing (a
Separate, Meta Invocation)") for exactly what it does with that access.

1. **Invoke `implementation-plan` once for sequencing.** Pass it the
   accepted ADR and its `Impacted Components` list, and tell it explicitly
   this is a cross-repo sequencing pass, not a single-repo execution plan.
2. It writes a sequencing doc at
   `docs/plans/XXX-feature-name-sequencing.md` (in whichever repo hosts the
   PRD/ADR/plan trio — inside its normal `docs/plans/**` edit scope, no new
   edit grant involved), ordering the epic's milestones by dependency. For
   each milestone it cites: which repo(s) it touches, which requirement(s)
   it covers, and its readiness per the ADR's `## 8. Requirement Readiness`
   section (detail-ready now vs. gated — carrying forward that section's
   guaranteed/contingent framing), plus what can run in parallel vs. what's
   strictly sequential (the ADR's `Constraints` section usually says
   which). This doc coordinates the *order* of later, per-repo
   `implementation-plan` invocations — it never replaces them.
3. **`implementation-plan` also reports back a concrete ticket-filing
   list, alongside the sequencing doc — not a vague "figure this out
   later."** One entry per milestone/phase, with a title, description, and
   which repo(s)/plan(s) it corresponds to — enough for someone else to
   actually file it. **Group coordinated cross-repo rollouts into a single
   ticket entry rather than splitting one per repo/PR** — e.g. if the ADR
   mandates repo A's and repo B's pieces land together in a specific
   sequence, that's one ticket entry, not two. `implementation-plan` never
   files tickets itself (no tracker-filing tool, and it isn't its job even
   if it had one — planning is); it only produces the list.
4. **Delegate the actual filing — do not file tickets yourself in this
   session either.** Per your own delegation-only charter, hand
   `implementation-plan`'s ticket report to a subagent to file, e.g.
   `general` (ticket-filing via a tracker/GitHub-issues tool doesn't cleanly
   fit `interview`/`architect`/`implementation-plan`/`build`/`reviewer`'s
   specific mandates). Keep each filed ticket lightly scoped (outcome,
   requirement(s) covered, known constraints/dependencies, and a link to
   the relevant ADR section) — not a detailed build blueprint; that gets
   filled in as each milestone is actually tackled.
5. **That same delegate also updates the sequencing doc with the final
   ticket IDs.** Once tickets are actually created, the delegate that filed
   them (e.g. `general`) is the only one that knows the resulting IDs — have
   it write those IDs back into `docs/plans/XXX-feature-name-sequencing.md`
   directly, rather than routing them back through you and
   `implementation-plan` again for no benefit.
6. Only then invoke `implementation-plan` again, per repo/milestone, in the
   order the sequencing doc establishes — respecting any gating from the
   ADR's `## 8. Requirement Readiness` section (`implementation-plan` also
   checks this itself; see its own instructions).

Skip this section entirely for single-repo ADRs — there's nothing to
sequence.

## 4. State Tracking

There is **no separate state or pointer file.** A feature's phase is
reconstructed on demand from its own on-disk artifacts — never copied into a
second file that could go stale or collide:

- **PRD** (`docs/prd/XXX-*.md`): `Status: Draft` vs. `Approved`.
- **ADR** (`docs/adr/XXX-*.md`): `Status: Proposed` vs. `Accepted`.
- **Plan** (`docs/plans/XXX-*.md`): checkbox completion.
- **Sequencing doc** (`docs/plans/XXX-*-sequencing.md`, multi-repo features
  only): exists once §3's automatic trigger has fired; each milestone's
  readiness there reflects the linked ADR's §8 Requirement Readiness.

To learn "what phase is feature XXX in," glob those paths for that number
and read their status fields (plus the sequencing doc, for multi-repo
features). This is the single source of truth.

Because each subagent invocation runs in an isolated context and only returns
its final output to you, anything a later phase needs from an earlier one
must travel through either (a) the on-disk artifact you tell it to read, or
(b) the specific prior-subagent output you paste into its prompt. Nothing is
carried by a shared state file.

**Multiple features in flight.** Since state lives in each numbered trio and
not in one global file, several features can be mid-flight at once (across
sessions, branches, or git worktrees) without colliding — each is fully
described by its own `XXX-*` artifacts. Within a single session you're
normally working one feature; keep its `XXX-slug` anchored in the
conversation so it's unambiguous which trio you mean.

## 5. The Multi-Agent Pipeline

For any new feature idea or non-trivial change request, route it through
this phase order. Do not skip phases.

```
User request -> interview -> architect -> architect-critic (advisory) -> implementation-plan (cross-repo sequencing pass, if multi-repo) -> general (ticket filing, if multi-repo) -> implementation-plan (per repo/milestone) -> build -> reviewer
```

| Phase | Subagent | Model | Trigger | Hold condition |
|---|---|---|---|---|
| 1. Problem refinement | `interview` | `google-vertex/gemini-3.5-flash` (medium) | New feature idea or change request with no PRD on disk | Do not advance until the PRD's status is `Approved` |
| 2a. Draft ADR | `architect` | `google-vertex/gemini-3.5-flash` (high) | Approved PRD exists, no ADR yet | Human co-drafts; ADR left `Proposed` |
| 2b. Adversarial review | `architect-critic` | `google-vertex/gemini-3.5-flash` (high) | An ADR draft exists (`Proposed`) and human finished co-drafting | Runs once, non-interactively; **advisory** — does not gate `Accepted` |
| 3. Cross-repo sequencing | `implementation-plan` (meta invocation), then `general` (ticket filing) | — | ADR reaches `Accepted` and its Impacted Components spans more than one repo | Automatic, not opt-in — see §3. The orchestrating session delegates sequencing to `implementation-plan`, which returns the sequencing doc plus a structured per-milestone ticket-filing report; the orchestrating session then delegates the actual ticket creation to `general`, which also stitches the resulting ticket IDs back into the sequencing doc. Skip entirely for single-repo ADRs. |
| 4. Task planning | `implementation-plan` | `google-vertex/gemini-3.5-flash` (medium) | ADR is accepted (and, for a multi-repo epic, this milestone's dependencies/gating are satisfied per the sequencing doc) | — |
| 5. Implementation | `build` | `google-vertex/gemini-3.5-flash` (low) | An execution plan exists on disk | — |
| 6. Review | `reviewer` | `google-vertex/gemini-3.5-flash` (high) | `build` reports all checklist items done and changes staged | **Pause and let the user review the staged `git diff` themselves first** — only invoke `reviewer` after they've looked it over |

Step 2b runs once per ADR draft in the normal flow and is advisory — it
never blocks `Proposed -> Accepted`, which remains a human decision, now an
informed one. A human may separately request a re-review of an
already-reviewed ADR outside this normal flow (e.g. after revising it) —
`architect-critic`'s own contract (Invariant 5) handles detecting and
writing up a second-or-later review; no special routing is needed for it.

**Failure recovery:** If a subagent reports failure (`build` can't get tests
passing after repeated attempts, or `reviewer` returns `STATUS: FAIL`), do
not proceed to the next phase. That failure is live context in the current
session — either delegate back to `implementation-plan`/`build` with the
specific issue, or bring it to the user if the design itself needs to change.

## 6. When Not to Use This Pipeline

For ad-hoc questions, single-file fixes, environment setup, or anything
genuinely small, just handle it directly in the main session — don't spin up
`interview`/`architect` for a one-line change. Still check `docs/adr/` for
relevant existing design contracts before editing, and if a request that
started small turns out to be a real feature, say so and propose routing it
through the pipeline instead.

## 7. Operational Rules

1. **No committing on your own initiative.** `build` stages changes
   (`git add`) but never runs `git commit`. Only commit when the user
   explicitly asks.
2. **Plan before code.** Don't start `build`-style implementation work until
   a matching, accepted ADR and execution plan exist on disk — for anything
   that actually went through the pipeline. This doesn't apply to the
   ad-hoc path in §6.
3. **Compiler/tests are the gate.** Code is not ready for `reviewer` if
   tests, lint, or the build are failing.
4. **Don't paper over a missing subagent.** If a subagent invocation fails
   for a platform reason, report the actual error and ask the user how to
   proceed — don't silently perform that subagent's role yourself to route
   around it.
5. **Known permission gap:** unlike some other agent tools, Claude Code's
   per-subagent restrictions are whole-tool only (Edit on/off, Bash on/off)
   — there's no engine-level "Edit is allowed only under docs/adr/" scoping.
   `interview`, `architect`, `architect-critic`, and `implementation-plan`'s
   "only touch your own docs/ subtree" constraint and `reviewer`'s "only
   inspect git history, never edit" constraint are enforced by the
   instructions in each subagent's own prompt, not by a permission rule.
   Don't casually violate those boundaries from the main session either
   (e.g. don't hand-edit an ADR yourself instead of delegating to
   `architect`).
6. **Don't invoke `implementation-plan` for a still-gated milestone.**
   Check the ADR's `## 8. Requirement Readiness` section (if present) and,
   for multi-repo epics, the sequencing doc from §3 before invoking
   `implementation-plan` for a given repo/milestone. If it's still blocked
   on an unresolved ticket or dependency, wait or say so explicitly to the
   user rather than planning ahead of the actual dependency.

## Subagents

Defined in `agents/` alongside this skill (symlinked into `~/.claude/agents`):
`interview`, `architect`, `architect-critic`, `implementation-plan`, `build`,
`reviewer`. See [`SMOKE_TEST.md`](../../../claude-code/SMOKE_TEST.md) for
manual verification of their tool-boundary enforcement and `effort:`
frontmatter behavior.
