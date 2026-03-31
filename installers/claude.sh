#!/usr/bin/env zsh

_install_claude_code() {
  log_info "Checking for Claude Code..."

  if brew list --cask claude-code &>/dev/null 2>&1; then
    log_ok "Claude Code already installed — $(claude --version 2>/dev/null || echo 'version unknown')."
    return
  fi

  log_info "Installing Claude Code..."
  brew install --cask claude-code

  if ! brew list --cask claude-code &>/dev/null 2>&1; then
    log_error "Claude Code installation failed."
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
