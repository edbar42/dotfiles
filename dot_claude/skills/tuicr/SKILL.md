---
name: tuicr
description: Review workflow built on tuicr + Herdr. Use whenever the user wants to review changes you made, mentions tuicr, asks for a review pane, or says comments are ready. Opens tuicr in a Herdr pane and reads the user's review comments back with `tuicr review`.
---

# tuicr Review Workflow (Herdr)

This machine runs a fixed setup: **tuicr** is the review TUI, **Herdr** is the
terminal workspace manager, and you are always running inside a Herdr pane.
There is no cmux, tmux, or Zellij here — never probe `$TMUX`, `$ZELLIJ`,
`$CMUX_WORKSPACE_ID`, or `$HERDR_ENV` to decide what to do. Just use Herdr.

The TUI is where the human reviews code; the `tuicr review` CLI is how you
discover sessions, read the user's comments, and (only when asked) write
agent-authored comments.

## Default Workflow: User-Led Review Of Your Changes

This is the workflow to assume unless the user says otherwise.

1. You finish a change in the repo.
2. You open a tuicr pane on the working-tree diff (see *Open A Review Pane*).
3. The user reads the diff and writes comments in the TUI.
4. When the user says comments are ready, or when the tuicr pane exits, you read
   them with `tuicr review comments` and act on them.

Rules for this workflow:

- Do **not** add your own comments to the session.
- Do **not** preemptively critique your own patch inside tuicr.
- Do **not** author comments that could read as the user's.

## The Other Workflow: Agent Review Of A Patch

Only when the user explicitly asks you to critique or summarize a patch inside
tuicr. Then you may add findings with `tuicr review add` and an explicit
`--username` identifying you. Ask before writing comments into a session if the
target session is at all ambiguous.

If intent is unclear, ask which of the two workflows the user wants.

## Open A Review Pane

Run the Herdr wrapper that ships with this skill:

```bash
<skill-directory>/tuicr-wrapper-herdr.sh /path/to/repo -- -w
```

Everything after `--` is passed straight to `tuicr`. Common scopes:

| Scope | Args |
| ------- | ------ |
| Uncommitted working-tree changes (default for reviewing your own edits) | `-- -w` |
| A commit range / revset | `-- -r <revset>` |
| One file or directory | `-- -p <path>` |
| Working tree plus commits | `-- -w -r <revset>` |

The wrapper returns as soon as the pane is running and prints the new pane id
between markers:

```text
=== TUICR PANE ===
w4:p7
=== END TUICR PANE ===
```

Capture that id — it is how you close the pane later:

```bash
herdr pane close <pane-id>
```

Useful wrapper flags:

- `--direction right|down` — split direction (default `right`)
- `--ratio <float>` — split ratio (default `0.5`)
- `--no-focus` — leave focus in your pane instead of moving to tuicr
- `--wait` — block until the user quits tuicr, then close the pane and return.
  Use a long tool timeout (10 minutes or more) with this. Prefer the default
  non-blocking mode so you can keep working and poll for comments.

The wrapper needs `jq` to read pane ids out of Herdr's JSON.

tuicr supports both git and Jujutsu (jj) repositories, and jj workspaces may
have no `.git` directory. Do not pre-check the directory with `git rev-parse`
or refuse to launch — run the wrapper and let it validate the repo.

## Attach To An Existing Session

If a review may already be open, list persisted sessions before starting a new
pane:

```bash
tuicr review list --repo /path/to/repo   # checkout + its repo's PR sessions
tuicr review list --repo owner/repo      # all sessions for a forge repo
tuicr review list --all                  # every session across all repos
```

`--repo` is a selector: a checkout path also surfaces PR sessions for that
checkout's `origin` repo, and a forge coordinate like `owner/repo` matches local
and PR sessions by owner/repo. Each row carries a `kind` (`local` or `pr`) and a
usable `slug`.

Choosing a session:

- Exactly one relevant session with `"active": true` → attach to it.
- Multiple active sessions, or an unclear match → ask the user for the slug.
- User gave a slug or session JSON path → use it directly.
- PR review → pass the PR slug (e.g. `gh:owner/repo/pr/N`) to `--session`; it is
  self-contained and needs no `--repo`.
- No active session → open one with the wrapper.

Treat `"active": true` as a convenience signal, not a stable protocol. If slug
resolution fails, ask the user for the slug or repo path.

## Read User Comments

This is the main loop. There is no push stream from tuicr; you read on demand.

```bash
tuicr review comments --repo /path/to/repo --session <slug>
```

The command emits JSON. Each comment includes `id`, `location`, `path`,
`start_line`, `end_line`, `side`, `comment_type`, `lifecycle_state`, and
`content`.

Act on `comment_type`:

- `issue` — blocking problem, fix first
- `suggestion` — implement, or explain why not
- `note` — answer or acknowledge
- `praise` — no action

Timing:

- Read immediately when the user says comments are ready.
- If you are explicitly waiting during an active review, poll about every 30
  seconds and diff the comment IDs against the previous result.
- Stop polling once the user says the review is done.
- Rerun `tuicr review comments` before claiming you finished the follow-up work
  — the user may have added comments while you worked.

If the result is empty, ask whether the comments were saved in the intended
session, or whether a different session should be selected.

## Add Agent Comments

Only in the agent-review workflow, and only after the user approves writing into
tuicr.

- Prefer line comments when you know the file and line.
- Use file comments for file-scoped feedback, review-level comments only for
  whole-review summaries.
- Default `--type issue` for problems; use `suggestion`, `note`, or `praise`
  when they fit better.
- Always pass `--username` so agent comments are visually distinguishable.

```bash
tuicr review add --repo /path/to/repo --session <slug> \
  --target-file src/main.rs \
  --line 42 \
  --side new \
  --type issue \
  --username "Claude" \
  "Handle the empty case here."
```

```bash
tuicr review add --repo /path/to/repo --session <slug> \
  --target-file src/main.rs \
  --type suggestion \
  --username "Claude" \
  "Consider splitting this file-level concern into a helper."
```

Omit `--target-file` for a review-level comment. Add `--end-line` for a range.
Use `--side old` for removed lines, `--side new` for added or unchanged lines.

For structured input, use `--input` with literal JSON, `@path/to/file.json`, or
`-` for stdin. Target types are `review`, `file`, `line`, and `line_range`.

## Herdr Pane Tips

- List panes: `herdr pane list`
- Read a pane without focusing it: `herdr pane read <pane-id>`
- Focus a pane: `herdr pane focus` (or click it in the Herdr UI)
- Close tuicr: the user presses `q`; force it with `herdr pane close <pane-id>`
- Wait for the pane to print something: `herdr pane wait-output --match <text> <pane-id>`

## Error Handling

| Situation | Action |
| ----------- | -------- |
| Multiple plausible active sessions | Ask which session slug to use |
| No active session | Open one with `tuicr-wrapper-herdr.sh` |
| Wrapper printed no pane id | Run `herdr pane list` to find it, or ask the user to start `tuicr` |
| `tuicr` not installed | Tell the user to install tuicr |
| `herdr` not reachable | Tell the user you are waiting for them to run `tuicr` in the repo, then attach with `tuicr review list` |
| Not a repository | Ask for the correct repo directory |
| Comments are empty | Confirm the selected session or ask the user to save comments |

## When Not To Use

- The user only wants raw `git diff` output.
- The user explicitly asks for a non-tuicr review workflow.
- The task is remote PR review with no tuicr PR session involved.
