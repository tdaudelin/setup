#!/usr/bin/env zsh

install_gcloud-cli() {
  if ! command -v brew &>/dev/null; then
    log_error "Homebrew is required to install Google Cloud CLI. Please install brew first."
    return 1
  fi

  log_info "Checking for Google Cloud CLI..."

  if command -v gcloud &>/dev/null; then
    log_ok "Google Cloud CLI already installed ($(gcloud version --format='value(Google Cloud SDK)' 2>/dev/null)) — updating..."
    brew upgrade --cask google-cloud-sdk
    return
  fi

  log_info "Installing Google Cloud CLI..."
  brew install --cask google-cloud-sdk

  if command -v gcloud &>/dev/null; then
    log_ok "Google Cloud CLI installed successfully."
  else
    log_error "Google Cloud CLI installation failed — 'gcloud' not found in PATH."
    return 1
  fi
}
