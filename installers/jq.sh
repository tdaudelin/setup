#!/usr/bin/env zsh

install_jq() {
  if ! command -v brew &>/dev/null; then
    log_error "Homebrew is required to install jq. Please install brew first."
    return 1
  fi

  log_info "Checking for jq..."

  if command -v jq &>/dev/null; then
    log_ok "jq already installed ($(jq --version)) — updating..."
    brew upgrade jq
    return
  fi

  log_info "Installing jq..."
  brew install jq

  if command -v jq &>/dev/null; then
    log_ok "jq installed ($(jq --version))."
  else
    log_error "jq installation failed — 'jq' not found in PATH."
    return 1
  fi
}
