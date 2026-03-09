#!/usr/bin/env zsh

install_ohmyzsh() {
  log_info "Checking for Oh My Zsh..."

  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    log_ok "Oh My Zsh already installed — updating..."
    "$HOME/.oh-my-zsh/tools/upgrade.sh"
  else
    log_info "Installing Oh My Zsh..."
    RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    log_error "Oh My Zsh installation failed — ~/.oh-my-zsh not found."
    return 1
  fi

  log_ok "Oh My Zsh installed successfully."
  _ohmyzsh_copy_custom
  _ohmyzsh_install_p10k
}

_ohmyzsh_install_p10k() {
  local p10k_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
  local zshrc="$HOME/.zshrc"

  if [[ -d "$p10k_dir" ]]; then
    log_ok "powerlevel10k already installed — updating..."
    git -C "$p10k_dir" pull --ff-only
  else
    log_info "Installing powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir"
  fi

  if [[ ! -d "$p10k_dir" ]]; then
    log_error "powerlevel10k installation failed — theme directory not found."
    return 1
  fi

  log_ok "powerlevel10k installed."

  # Set ZSH_THEME in ~/.zshrc
  if grep -q '^ZSH_THEME=' "$zshrc"; then
    if grep -q '^ZSH_THEME="powerlevel10k/powerlevel10k"' "$zshrc"; then
      log_ok "ZSH_THEME already set to powerlevel10k."
    else
      sed -i '' 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' "$zshrc"
      log_ok "ZSH_THEME updated to powerlevel10k/powerlevel10k in ~/.zshrc."
    fi
  else
    log_warn "ZSH_THEME line not found in ~/.zshrc — could not set powerlevel10k theme."
  fi
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
