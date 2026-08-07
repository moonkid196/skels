---
name: pr-conventions
description: >
  Use this when creating a GitHub pull request via the gh CLI, or when
  explicitly asked to update, fill out, or fix a PR's title or
  description. Standardizes PR titles (Conventional Commits format) and
  descriptions (a why-then-what template).
  Requires the gh CLI — if it isn't available, say so and stop rather
  than falling back to the GitHub web UI or raw REST calls.
---

# PR Conventions

## Preflight

Run `gh --version` before doing anything else here. If `gh` isn't
installed or isn't authenticated, tell the user and stop — don't work
around it via `curl`/the GitHub API directly or by describing what to
paste into the web UI.

## Title format

```
^(feat|fix|docs|style|refactor|test|chore)(\([a-z0-9-]+\))?!?: [a-z0-9].*[^.]$
```

- **type** — pick the one that best represents the change's primary
  intent (same as commit-message `type`, not necessarily the literal
  count of files touched).
- **scope** — optional, lowercase-kebab-case, the module/directory/
  feature touched (e.g. `agents`, `auth`, `api`). Omit it if the change is
  repo-wide or doesn't cleanly map to one area — don't force a scope that
  doesn't fit.
- **description** — lowercase, imperative mood, no trailing period.

Before assuming this exact set applies, check the target repo for its own
title-check workflow (grep `.github/workflows/*.yml` for something like
`pr-title-check.yml`) and defer to its regex if it differs. Otherwise
apply this format anyway for consistency, even in repos with no CI
enforcing it.

Examples:
- `docs(agents): add overview and related-repos context to agents.md`
- `docs(agents): add related-repos context to AGENTS.md`
- `docs(agents): add shared skills, subagents, and cross-repo index`

## Classifying changes to agent/AI instructions

Changes to `AGENTS.md`, `CLAUDE.md`, skill files (`SKILL.md`), subagent
definitions, or slash commands look like documentation (markdown, prose)
but aren't always — how to classify them (the `type` in the title, and the
label) depends on what the repo is *for*:

- **The repo's primary tracked artifact is itself agent/AI instructions**
  (e.g. a repo whose sole purpose is to hold shared agent/skill
  definitions) — these instructions are the product, not incidental
  documentation of one. Use `feat` as the type, and the `enhancement`
  label (or repo equivalent) instead of `docs`/`documentation`.
- **The repo's primary purpose is a code/service/product**, and agent/AI
  instructions are a supporting file alongside the real code — treat the
  change conceptually as *automation* (a feature/improvement in how
  agents work with that codebase), not incidental prose. Conventional
  Commits has no `automation` type, so `docs` remains a reasonable type
  prefix here. For the **label**, check `gh label list` first: if the
  repo has an `automation`-flavored label, prefer it over `documentation`.
  If no such label exists, `documentation` is fine — don't invent one.

## Description template

```
<Why — 1-3 sentences: what was missing, wrong, or motivating this change
before it existed. Not a restatement of the diff.>

<What — bullet list of concrete changes, anchored to file paths or
section names where that helps a reviewer orient.>

<Optional — what's explicitly unchanged/out of scope, or a pointer to
follow-up work.>
```

Process rules that matter more than the template shape itself:

- **Read the full commit history on the branch** (`git log
  <base>..<branch>`) before writing or updating a description — don't
  describe only the latest commit. A PR branch often accumulates several
  commits pushed over time, and the description needs to reflect the
  whole thing, not just what triggered the update.
- **Verify factual claims against current state before writing them
  down.** Re-grep/re-read rather than recalling from memory — a count or
  file list stated confidently but wrong is worse than a vague sentence.
- **When an existing title/description is auto-generated or stale**
  (branch name as the title, empty body, a title copied from a single
  commit that no longer reflects the whole branch), rewrite it fully —
  don't patch around a broken starting point.

## Optional metadata

- **Assignee** — default to self (`gh pr create -a @me` / `gh pr edit
  --add-assignee @me`).
- **Labels** — propose a best-guess set drawn from the repo's *existing*
  labels (`gh label list`) matched to what the diff actually does. Never
  invent a label that doesn't already exist in the repo. For changes to
  agent/AI instruction files specifically, see "Classifying changes to
  agent/AI instructions" above before defaulting to `documentation`.
- **Confirm before applying** — surface the proposed assignee and labels
  to the user and wait for a go-ahead before actually setting them. Don't
  apply either silently.
- **Reviewers, milestone, project** — available via `gh pr create
  --reviewer/--milestone/--project` and `gh pr edit
  --add-reviewer/--milestone/--add-project`, but only set these if the
  user explicitly asks. Don't guess who should review something or which
  milestone/project it belongs to.

## Draft status

Always create PRs as drafts (`gh pr create --draft`), regardless of how
polished the change feels. Marking a PR ready for review (`gh pr ready`)
is a separate, explicit step — don't do it automatically just because the
diff looks complete; wait for the user to ask, or ask them directly if it
seems ready.

This applies whenever this skill triggers PR creation, not just when the
user explicitly asks for a draft.

## Merge method

Not settable at PR creation, and `gh pr edit` has no merge-method flag —
it's only chosen at merge time (`gh pr merge --merge|--squash|--rebase`).
Before suggesting or using one, check what the repo actually allows:

```
gh api repos/{owner}/{repo} --jq '{allow_merge_commit, allow_squash_merge, allow_rebase_merge}'
```

Most repos enforce exactly one method — don't offer a merge flag the repo
disallows.
