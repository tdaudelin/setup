#!/usr/bin/env zsh

install_docker() {
  if ! command -v brew &>/dev/null; then
    log_error "Homebrew is required to install Docker Desktop. Please install brew first."
    return 1
  fi

  log_info "Checking for Docker Desktop..."

  if [[ -d "/Applications/Docker.app" ]]; then
    log_ok "Docker Desktop already installed — updating..."
    brew upgrade --cask docker
    return
  fi

  log_info "Installing Docker Desktop..."
  brew install --cask docker

  if [[ -d "/Applications/Docker.app" ]]; then
    log_ok "Docker Desktop installed successfully."
  else
    log_error "Docker Desktop installation failed — app not found in /Applications."
    return 1
  fi
}
