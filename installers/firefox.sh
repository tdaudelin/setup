#!/usr/bin/env zsh

install_firefox() {
  if ! command -v brew &>/dev/null; then
    log_error "Homebrew is required to install Firefox. Please install brew first."
    return 1
  fi

  log_info "Checking for Firefox..."

  if [[ -d "/Applications/Firefox.app" ]]; then
    log_ok "Firefox already installed — updating..."
    brew upgrade --cask firefox
  else
    log_info "Installing Firefox..."
    brew install --cask firefox
  fi

  if [[ ! -d "/Applications/Firefox.app" ]]; then
    log_error "Firefox installation failed — app not found in /Applications."
    return 1
  fi

  log_ok "Firefox installed successfully."
}
