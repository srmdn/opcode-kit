# opcode-kit

Small Unix-style helpers for OpenCode workflows.

## Tools

### `oc-last`

- find recent OpenCode sessions for current directory
- preview session context before resume
- reopen intended session without guessing

### `opcode-switch`

- switch between local OpenCode accounts
- save current auth as named profile
- activate another account without editing auth files by hand

## Install

Install all tools:

```bash
curl -fsSL https://raw.githubusercontent.com/srmdn/opcode-kit/main/install.sh | bash
```

Install `oc-last` only:

```bash
curl -fsSL https://raw.githubusercontent.com/srmdn/opcode-kit/main/install.sh | bash -s -- oc-last
```

Install `opcode-switch` only:

```bash
curl -fsSL https://raw.githubusercontent.com/srmdn/opcode-kit/main/install.sh | bash -s -- opcode-switch
```

Install from local checkout:

```bash
./install.sh
```

Install one tool from local checkout:

```bash
./install.sh oc-last
```

Requires:

- `bash`
- [OpenCode](https://opencode.ai/)

Tool-specific notes:

- `oc-last` needs `sqlite3`
- `opcode-switch --verify` needs `opencode` on `PATH`
- `install.sh` with no args installs all tools in `bin/`
- `install.sh <tool>` installs one tool only

## Quick Start

Session recovery:

```bash
oc-last
oc-last --show 1
oc-last --open 1
oc-last --recent
```

Account switching:

```bash
opcode-switch
opcode-switch --save personal
opcode-switch work
opcode-switch --verify
```

## Example Output

```text
$ oc-last
OpenCode sessions for:
  /path/to/project

[1] Fix installer edge case
     id: ses_abc123
     dir: /path/to/project
     updated: 2026-06-23 19:41:02
     messages: 38
     first user: make install.sh support one-tool installs too
     last user: sanitize repo before first commit
     last assistant: no confidential data found in tracked files...

Next:
  oc-last --show N
  oc-last --open N
```

## Why This Exists

OpenCode keeps local session history, but finding the right session later is not always easy.

Common failure mode:

- a session still exists
- the user knows useful context is still somewhere in local history
- built-in session discovery is not enough to quickly find and resume the right one

`opcode-kit` exists to fill gaps like that with small, inspectable command-line tools.

## Repo Shape

`opcode-kit` is a small monorepo toolbox.

Each tool is a standalone executable in `bin/`, with focused docs in `docs/`.

```text
opcode-kit/
  README.md
  LICENSE
  install.sh
  bin/
    oc-last
    opcode-switch
    ...
  docs/
    oc-last.md
    opcode-switch.md
    ...
```

Shared repo, separate commands. No heavy framework, no package-manager lock-in.

## Principles

- keep tools small
- keep tools readable
- prefer direct shell workflows
- avoid unnecessary dependencies
- solve real OpenCode workflow problems

## Docs

- [docs/oc-last.md](docs/oc-last.md)
- [docs/opcode-switch.md](docs/opcode-switch.md)

## License

MIT
