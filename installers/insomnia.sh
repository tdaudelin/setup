#!/usr/bin/env zsh

install_insomnia() {
  if ! command -v brew &>/dev/null; then
    log_error "Homebrew is required to install Insomnia. Please install brew first."
    return 1
  fi

  log_info "Checking for Insomnia..."

  if [[ -d "/Applications/Insomnia.app" ]]; then
    log_ok "Insomnia already installed — updating..."
    brew upgrade --cask insomnia
    return
  fi

  log_info "Installing Insomnia..."
  brew install --cask insomnia

  if [[ -d "/Applications/Insomnia.app" ]]; then
    log_ok "Insomnia installed successfully."
  else
    log_error "Insomnia installation failed — app not found in /Applications."
    return 1
  fi
}
