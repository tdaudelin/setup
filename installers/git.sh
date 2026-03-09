#!/usr/bin/env zsh

install_git() {
  if ! command -v brew &>/dev/null; then
    log_error "Homebrew is required to install git. Please install brew first."
    return 1
  fi

  log_info "Checking for Homebrew git..."

  if brew list git &>/dev/null; then
    log_ok "Homebrew git already installed ($(git --version)) — updating..."
    brew upgrade git
  else
    log_info "Installing git from Homebrew..."
    brew install git
  fi

  if ! command -v git &>/dev/null; then
    log_error "git installation failed — 'git' not found in PATH."
    return 1
  fi

  log_ok "git installed successfully — $(git --version)."
  ensure_omz_plugin "git"
}
