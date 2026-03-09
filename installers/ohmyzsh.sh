#!/usr/bin/env zsh

install_ohmyzsh() {
  log_info "Checking for Oh My Zsh..."

  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    log_ok "Oh My Zsh already installed — updating..."
    "$HOME/.oh-my-zsh/tools/upgrade.sh"
    return
  fi

  log_info "Installing Oh My Zsh..."
  RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    log_error "Oh My Zsh installation failed — ~/.oh-my-zsh not found."
    return 1
  fi

  log_ok "Oh My Zsh installed successfully."

  _ohmyzsh_copy_custom
}

_ohmyzsh_copy_custom() {
  local custom_src="$HOME/setup/custom"
  local custom_dst="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

  if [[ ! -d "$custom_src" ]]; then
    log_warn "No custom files found at $custom_src — skipping."
    return
  fi

  log_info "Copying custom files to $custom_dst..."
  cp -r "$custom_src"/. "$custom_dst/"
  log_ok "Custom files copied."
}
