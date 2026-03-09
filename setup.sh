#!/usr/bin/env zsh

set -euo pipefail
setopt KSH_ARRAYS   # 0-based array indexing

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/utils.sh"
source "$SCRIPT_DIR/menu.sh"

# ---------------------------------------------------------------------------
# Guard: macOS only
# ---------------------------------------------------------------------------

if [[ "$(uname -s)" != "Darwin" ]]; then
  log_error "This script only supports macOS. Detected OS: $(uname -s)"
  exit 1
fi

# ---------------------------------------------------------------------------
# Tool catalogue — "key|label|description"
# ---------------------------------------------------------------------------

TOOLS=(
  "brew|Homebrew|Package manager for macOS"
  "mise|mise-en-place|Polyglot runtime version manager (replaces nvm, pyenv, etc.)"
  "docker|Docker Desktop|Containerisation platform"
  "vscode|Visual Studio Code|Code editor by Microsoft"
  "jetbrains|JetBrains Toolbox|Launcher and updater for JetBrains IDEs"
  "awscli|AWS CLI|Command-line interface for Amazon Web Services"
  "jq|jq|Lightweight command-line JSON processor"
  "insomnia|Insomnia|REST / GraphQL API client"
)

# ---------------------------------------------------------------------------
# Run
# ---------------------------------------------------------------------------

if run_menu "Mac Setup — Tool Menu" "${TOOLS[@]}"; then
  printf "\n"
  log_info "Installing the following tools:"
  for key in "${MENU_SELECTED[@]}"; do
    printf "    • %s\n" "$key"
  done
  printf "\n"

  for key in "${MENU_SELECTED[@]}"; do
    installer="$SCRIPT_DIR/installers/${key}.sh"
    if [[ -f "$installer" ]]; then
      source "$installer"
      "install_${key}"
    else
      log_error "No installer found for: $key"
    fi
  done
else
  log_info "Exiting. Nothing was installed."
fi
