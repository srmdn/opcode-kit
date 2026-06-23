#!/usr/bin/env bash

set -euo pipefail

PREFIX="${PREFIX:-$HOME/.local}"
BIN_DIR="$PREFIX/bin"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<'EOF'
Usage:
  ./install.sh
  ./install.sh all
  ./install.sh opcode-last
  ./install.sh opcode-switch
  PREFIX=/custom/prefix ./install.sh

Notes:
  - Default installs all available tools in `bin/`.
  - You can pass one or more tool names to install selectively.
EOF
}

list_available_tools() {
  local path
  for path in "$SOURCE_DIR"/bin/*; do
    [ -f "$path" ] || continue
    basename "$path"
  done
}

install_tool() {
  local tool="$1"
  local source_file="$SOURCE_DIR/bin/$tool"
  local target="$BIN_DIR/$tool"

  [ -f "$source_file" ] || {
    printf 'install.sh: tool not found: %s\n' "$tool" >&2
    exit 1
  }

  install -m 0755 "$source_file" "$target"
  printf 'Installed %s to %s\n' "$tool" "$target"
}

warn_tool_dependencies() {
  local tool="$1"
  case "$tool" in
    oc-last)
      if ! command -v sqlite3 >/dev/null 2>&1; then
        printf 'Warning: sqlite3 not found on PATH. %s needs sqlite3.\n' "$tool" >&2
      fi
      ;;
    opcode-last)
      if ! command -v sqlite3 >/dev/null 2>&1; then
        printf 'Warning: sqlite3 not found on PATH. %s needs sqlite3.\n' "$tool" >&2
      fi
      ;;
    opcode-switch)
      if ! command -v opencode >/dev/null 2>&1; then
        printf 'Warning: opencode not found on PATH. %s --verify needs opencode.\n' "$tool" >&2
      fi
      ;;
  esac
}

TOOLS=()

if [ "$#" -eq 0 ]; then
  while IFS= read -r tool; do
    TOOLS+=("$tool")
  done < <(list_available_tools)
else
  for arg in "$@"; do
    case "$arg" in
      -h|--help)
        usage
        exit 0
        ;;
      all)
        while IFS= read -r tool; do
          TOOLS+=("$tool")
        done < <(list_available_tools)
        ;;
      *)
        TOOLS+=("$arg")
        ;;
    esac
  done
fi

[ "${#TOOLS[@]}" -gt 0 ] || {
  printf 'install.sh: no tools available to install\n' >&2
  exit 1
}

mkdir -p "$BIN_DIR"

for tool in "${TOOLS[@]}"; do
  install_tool "$tool"
  warn_tool_dependencies "$tool"
done

if [[ " ${TOOLS[*]} " == *" opcode-last "* ]] && [[ " ${TOOLS[*]} " != *" oc-last "* ]]; then
  install_tool "oc-last"
fi

if [ ":$PATH:" != *":$BIN_DIR:"* ]; then
  printf 'Note: %s not on PATH\n' "$BIN_DIR"
fi
