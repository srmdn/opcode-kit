# opcode-switch

`opcode-switch` switches between multiple OpenCode accounts by replacing the local auth file OpenCode reads at startup.

## Install

Install via repo installer:

```bash
curl -fsSL https://raw.githubusercontent.com/srmdn/opcode-kit/main/install.sh | bash -s -- opcode-switch
```

Or install direct binary:

```bash
curl -fsSL -o "$HOME/.local/bin/opcode-switch" \
  https://raw.githubusercontent.com/srmdn/opcode-kit/main/bin/opcode-switch
chmod +x "$HOME/.local/bin/opcode-switch"
```

## What It Manages

- active auth file: `$HOME/.local/share/opencode/auth.json`
- saved accounts: `$HOME/.opencode/keys/*.json`

It works by copying one saved account file into the active OpenCode auth path.

## Commands

```text
opcode-switch
opcode-switch <name>
opcode-switch --save <name>
opcode-switch --add <name> <key>
opcode-switch --rename <old> <new>
opcode-switch --verify
```

Behavior:

- no args: list saved accounts and mark active one
- `<name>`: switch active account
- `--save <name>`: save current auth as named account
- `--add <name> <key>`: create named account from raw API key
- `--rename <old> <new>`: rename saved account
- `--verify`: ask OpenCode to validate current key

## Security Notes

- saved account files are written with `chmod 600`
- keys stay in local files, not shell env vars
- do not commit saved key files to git
- do not sync saved key files through public or shared storage

## Notes

- switching affects future OpenCode launches, not already-running sessions
- `--verify` requires `opencode` on `PATH`
