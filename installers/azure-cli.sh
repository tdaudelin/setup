#!/usr/bin/env zsh

install_azure-cli() {
  if ! command -v brew &>/dev/null; then
    log_error "Homebrew is required to install Azure CLI. Please install brew first."
    return 1
  fi

  log_info "Checking for Azure CLI..."

  if command -v az &>/dev/null; then
    log_ok "Azure CLI already installed ($(az version --query '"azure-cli"' -o tsv 2>/dev/null)) — updating..."
    brew upgrade azure-cli
  else
    log_info "Installing Azure CLI..."
    brew install azure-cli
  fi

  if ! command -v az &>/dev/null; then
    log_error "Azure CLI installation failed — 'az' not found in PATH."
    return 1
  fi

  log_ok "Azure CLI installed successfully — $(az version --query '"azure-cli"' -o tsv 2>/dev/null)."
  ensure_omz_plugin "azure"
}
