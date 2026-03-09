#!/usr/bin/env zsh

install_jetbrains() {
  if ! command -v brew &>/dev/null; then
    log_error "Homebrew is required to install JetBrains Toolbox. Please install brew first."
    return 1
  fi

  log_info "Checking for JetBrains Toolbox..."

  if [[ -d "/Applications/JetBrains Toolbox.app" ]]; then
    log_ok "JetBrains Toolbox already installed — updating..."
    brew upgrade --cask jetbrains-toolbox
  else
    log_info "Installing JetBrains Toolbox..."
    brew install --cask jetbrains-toolbox
  fi

  if [[ ! -d "/Applications/JetBrains Toolbox.app" ]]; then
    log_error "JetBrains Toolbox installation failed — app not found in /Applications."
    return 1
  fi

  log_ok "JetBrains Toolbox installed successfully."
}
