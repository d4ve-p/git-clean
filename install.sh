#!/usr/bin/env sh
# Installer for git-clean on Unix / macOS / Git Bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="${1:-$HOME/.local/bin}"

mkdir -p "$TARGET_DIR"

cp "$SCRIPT_DIR/git-clean" "$TARGET_DIR/git-clean"
chmod +x "$TARGET_DIR/git-clean"

# If on Windows/Git Bash, also copy the cmd wrapper
if [ -f "$SCRIPT_DIR/git-clean.cmd" ]; then
  cp "$SCRIPT_DIR/git-clean.cmd" "$TARGET_DIR/git-clean.cmd"
fi

echo "✓ git-clean installed successfully to: $TARGET_DIR/git-clean"

case ":$PATH:" in
  *":$TARGET_DIR:"*) ;;
  *)
    echo ""
    echo "Notice: $TARGET_DIR is not in your PATH."
    echo "Add it by running:"
    echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
    ;;
esac
