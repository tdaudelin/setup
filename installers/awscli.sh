#!/usr/bin/env zsh

install_awscli() {
  if ! command -v brew &>/dev/null; then
    log_error "Homebrew is required to install AWS CLI. Please install brew first."
    return 1
  fi

  log_info "Checking for AWS CLI..."

  if command -v aws &>/dev/null; then
    log_ok "AWS CLI already installed ($(aws --version 2>&1)) — updating..."
    brew upgrade awscli
  else
    log_info "Installing AWS CLI..."
    brew install awscli
  fi

  if ! command -v aws &>/dev/null; then
    log_error "AWS CLI installation failed — 'aws' not found in PATH."
    return 1
  fi

  log_ok "AWS CLI installed successfully — $(aws --version 2>&1)."
  ensure_omz_plugin "aws"
}
