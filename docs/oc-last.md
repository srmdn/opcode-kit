# opcode-last

`opcode-last` helps find and reopen OpenCode sessions tied to repo context.

Compatibility alias:

- `oc-last` forwards to `opcode-last`

## Install

Install via repo installer:

```bash
curl -fsSL https://raw.githubusercontent.com/srmdn/opcode-kit/main/install.sh | bash -s -- opcode-last
```

Or install direct binary:

```bash
curl -fsSL -o "$HOME/.local/bin/opcode-last" \
  https://raw.githubusercontent.com/srmdn/opcode-kit/main/bin/opcode-last
chmod +x "$HOME/.local/bin/opcode-last"
```

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
opcode-last
opcode-last --all
opcode-last --limit N
opcode-last --dir PATH
opcode-last --show N
opcode-last --open N
opcode-last --recent
```

Behavior:

- `opcode-last`: list recent sessions for exact current directory
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

If none found, `opcode-last` exits with clear error.

## Fallback Behavior

If exact directory match returns no rows:

- list mode falls back to recent sessions from all directories
- `--show` and `--open` do not fallback silently; they stay scoped to current result set

Reason: list mode should help discovery, but indexed actions should stay predictable.
