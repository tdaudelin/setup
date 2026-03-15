#!/usr/bin/env zsh

install_dev-tools() {
  if ! command -v brew &>/dev/null; then
    log_error "Homebrew is required to install misc dev tools. Please install brew first."
    return 1
  fi

  local tools=(jq tmux)

  for tool in "${tools[@]}"; do
    log_info "Checking for ${tool}..."

    if command -v "$tool" &>/dev/null; then
      log_ok "${tool} already installed — updating..."
      brew upgrade "$tool" 2>/dev/null || true
    else
      log_info "Installing ${tool}..."
      brew install "$tool"
    fi

    if ! command -v "$tool" &>/dev/null; then
      log_error "${tool} installation failed — '${tool}' not found in PATH."
      return 1
    fi

    log_ok "${tool} installed successfully."
  done
}
