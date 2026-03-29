#!/usr/bin/env zsh

_install_claude_code() {
  log_info "Checking for Claude Code..."

  if command -v claude &>/dev/null; then
    log_ok "Claude Code already installed — $(claude --version 2>/dev/null || echo 'version unknown')."
    log_info "To update, run: curl -fsSL https://claude.ai/install.sh | bash"
    return
  fi

  log_info "Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash
  PATH="$HOME/.local/bin:$PATH"

  if ! command -v claude &>/dev/null; then
    log_error "Claude Code installation failed — 'claude' command not found."
    return 1
  fi

  log_ok "Claude Code installed successfully — $(claude --version 2>/dev/null || echo 'version unknown')."
}

_install_claude_desktop() {
  log_info "Checking for Claude Desktop..."

  if brew list --cask claude &>/dev/null 2>&1; then
    log_ok "Claude Desktop already installed."
    return
  fi

  log_info "Installing Claude Desktop..."
  brew install --cask claude

  if ! brew list --cask claude &>/dev/null 2>&1; then
    log_error "Claude Desktop installation failed."
    return 1
  fi

  log_ok "Claude Desktop installed successfully."
}

install_claude() {
  _install_claude_code
  _install_claude_desktop
}
