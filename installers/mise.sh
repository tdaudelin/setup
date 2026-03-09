#!/usr/bin/env zsh

install_mise() {
  log_info "Checking for mise..."

  if command -v mise &>/dev/null; then
    log_ok "mise already installed ($(mise --version)) — updating..."
    brew upgrade mise
  else
    if ! command -v brew &>/dev/null; then
      log_error "Homebrew is required to install mise. Please install brew first."
      return 1
    fi

    log_info "Installing mise via Homebrew..."
    brew install mise
  fi

  if ! command -v mise &>/dev/null; then
    log_error "mise installation failed — not found in PATH."
    return 1
  fi

  log_ok "mise installed successfully — $(mise --version)."
  ensure_omz_plugin "mise"
}
