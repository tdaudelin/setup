#!/usr/bin/env zsh

# ---------------------------------------------------------------------------
# Colours — defined as $'...' so they contain real escape characters
# ---------------------------------------------------------------------------

RED=$'\033[0;31m'
YELLOW=$'\033[0;33m'
GREEN=$'\033[0;32m'
CYAN=$'\033[0;36m'
BOLD=$'\033[1m'
DIM=$'\033[2m'
RESET=$'\033[0m'

# ---------------------------------------------------------------------------
# Logging
# ---------------------------------------------------------------------------

log_error() { printf "${RED}[ERROR]${RESET} %s\n" "$*" >&2; }
log_warn()  { printf "${YELLOW}[WARN]${RESET}  %s\n" "$*"; }
log_info()  { printf "${CYAN}[INFO]${RESET}  %s\n" "$*"; }
log_ok()    { printf "${GREEN}[ OK ]${RESET}  %s\n" "$*"; }

# ---------------------------------------------------------------------------
# .zshrc helpers
# ---------------------------------------------------------------------------

# ensure_omz_plugin <plugin>
#
# Adds <plugin> to the plugins=(...) line in ~/.zshrc if not already present.
# Requires Oh My Zsh to be installed first.
ensure_omz_plugin() {
  local plugin="$1"
  local zshrc="$HOME/.zshrc"

  if [[ ! -f "$zshrc" ]]; then
    log_warn "~/.zshrc not found — cannot add plugin '$plugin'."
    return 1
  fi

  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    log_warn "Oh My Zsh is not installed — cannot add plugin '$plugin'."
    return 1
  fi

  # Already present — nothing to do
  if grep -qE "plugins=\([^)]*\b${plugin}\b[^)]*\)" "$zshrc"; then
    log_ok "Oh My Zsh plugin '$plugin' already enabled."
    return
  fi

  # Append plugin name inside the existing single-line plugins=(...) entry
  sed -i '' "s/^plugins=(\(.*\))$/plugins=(\1 ${plugin})/" "$zshrc"

  if grep -qE "plugins=\([^)]*\b${plugin}\b[^)]*\)" "$zshrc"; then
    log_ok "Oh My Zsh plugin '$plugin' enabled in ~/.zshrc."
  else
    log_warn "Could not add plugin '$plugin' — plugins=(...) line may span multiple lines."
  fi
}

# ---------------------------------------------------------------------------
# Terminal helpers
# ---------------------------------------------------------------------------

cursor_up()    { printf "\033[%dA" "$1"; }
clear_to_end() { printf "\033[J"; }
cursor_hide()  { printf "\033[?25l"; }
cursor_show()  { printf "\033[?25h"; }
