#!/usr/bin/env zsh

# ---------------------------------------------------------------------------
# bootstrap.sh — fresh-system entry point
#
# Usage (no git required):
#   curl -fsSL https://raw.githubusercontent.com/tdaudelin/setup/main/bootstrap.sh | zsh
# ---------------------------------------------------------------------------

set -euo pipefail

REPO_URL="https://github.com/tdaudelin/setup.git"
CLONE_DIR="$HOME/.setup"

# ---------------------------------------------------------------------------
# Ensure Xcode Command Line Tools (provides git, curl, etc.)
# ---------------------------------------------------------------------------

if ! command -v git &>/dev/null; then
  echo "[INFO]  git not found — triggering Xcode Command Line Tools installation..."
  xcode-select --install 2>/dev/null || true
  echo ""
  echo "[INFO]  Please complete the Xcode CLT installation prompt, then re-run:"
  echo ""
  echo "    curl -fsSL https://raw.githubusercontent.com/tdaudelin/setup/main/bootstrap.sh | zsh"
  echo ""
  exit 0
fi

# ---------------------------------------------------------------------------
# Clone or update the setup repo
# ---------------------------------------------------------------------------

if [[ -d "$CLONE_DIR/.git" ]]; then
  echo "[INFO]  Found existing clone at $CLONE_DIR — pulling latest..."
  git -C "$CLONE_DIR" pull --ff-only
else
  echo "[INFO]  Cloning setup repo to $CLONE_DIR..."
  git clone "$REPO_URL" "$CLONE_DIR"
fi

# ---------------------------------------------------------------------------
# Hand off to setup.sh
# ---------------------------------------------------------------------------

zsh "$CLONE_DIR/setup.sh"
