# oc-last

`oc-last` helps find and reopen OpenCode sessions tied to repo context.

## What It Reads

- default DB: `$HOME/.local/share/opencode/opencode.db`
- override with: `OPENCODE_DB=/path/to/opencode.db`

It queries local SQLite only. No network.

## What It Shows

For each session:

- title
- session id
- directory
- updated time
- message count
- first user prompt
- last user prompt
- last assistant snippet

## Flags

```text
oc-last
oc-last --all
oc-last --limit N
oc-last --dir PATH
oc-last --show N
oc-last --open N
oc-last --recent
```

Behavior:

- `oc-last`: list recent sessions for exact current directory
- `--all`: expand limit from `5` to `20`
- `--limit N`: custom row count
- `--dir PATH`: query another directory without `cd`
- `--show N`: detailed preview for indexed row
- `--open N`: resume indexed session via OpenCode
- `--recent`: ignore directory match, show recent sessions from any directory

## OpenCode Binary Lookup

Resume path checks:

1. `OPENCODE_BIN` if set and executable
2. `$HOME/.opencode/bin/opencode`
3. `opencode` on `PATH`

If none found, `oc-last` exits with clear error.

## Fallback Behavior

If exact directory match returns no rows:

- list mode falls back to recent sessions from all directories
- `--show` and `--open` do not fallback silently; they stay scoped to current result set

Reason: list mode should help discovery, but indexed actions should stay predictable.
