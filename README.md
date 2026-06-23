# opcode-kit

Small Unix-style helpers for OpenCode workflows.

## Why This Exists

OpenCode keeps local session history, but finding the right session later is not always easy.

Common failure mode:

- a session still exists
- the user knows useful context is still somewhere in local history
- built-in session discovery is not enough to quickly find and resume the right one

`opcode-kit` exists to fill gaps like that with small, inspectable command-line tools.

First tool: `oc-last`

- list recent OpenCode sessions for current working directory
- show useful preview context before resume
- reopen the intended session with `opencode --session <id>`

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
    ...
  docs/
    oc-last.md
    ...
```

Shared repo, separate commands. No heavy framework, no package-manager lock-in.

## Install

Install all current tools:

```bash
curl -fsSL https://raw.githubusercontent.com/srmdn/opcode-kit/main/install.sh | bash
```

Install from a local checkout:

```bash
./install.sh
```

Install one tool only:

```bash
./install.sh oc-last
```

Requires:

- `bash`
- `sqlite3`
- [OpenCode](https://opencode.ai/)

## Usage

```bash
oc-last
oc-last --all
oc-last --show 2
oc-last --open 1
oc-last --recent
oc-last --dir /path/to/project
```

## Principles

- keep tools small
- keep tools readable
- prefer direct shell workflows
- avoid unnecessary dependencies
- solve real OpenCode workflow problems

## Docs

- [docs/oc-last.md](docs/oc-last.md)

## License

MIT
