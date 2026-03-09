#!/usr/bin/env zsh

install_brew() {
  log_info "Checking for Homebrew..."

  if command -v brew &>/dev/null; then
    log_ok "Homebrew already installed — updating..."
    brew update
  else
    log_info "Homebrew not found — installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add brew to PATH for the remainder of this session
    if [[ -x /opt/homebrew/bin/brew ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x /usr/local/bin/brew ]]; then
      eval "$(/usr/local/bin/brew shellenv)"
    fi
  fi

  if ! command -v brew &>/dev/null; then
    log_error "Homebrew installation failed — brew not found in PATH."
    return 1
  fi

  log_ok "Homebrew installed successfully — $(brew --version | head -1)."
  ensure_omz_plugin "brew"
}
