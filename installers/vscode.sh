#!/usr/bin/env zsh

install_vscode() {
  if ! command -v brew &>/dev/null; then
    log_error "Homebrew is required to install VS Code. Please install brew first."
    return 1
  fi

  log_info "Checking for Visual Studio Code..."

  if [[ -d "/Applications/Visual Studio Code.app" ]]; then
    log_ok "VS Code already installed — updating..."
    brew upgrade --cask visual-studio-code
    return
  fi

  log_info "Installing Visual Studio Code..."
  brew install --cask visual-studio-code

  if [[ -d "/Applications/Visual Studio Code.app" ]]; then
    log_ok "VS Code installed successfully."
    _vscode_install_cli
  else
    log_error "VS Code installation failed — app not found in /Applications."
    return 1
  fi
}

_vscode_install_cli() {
  local bundle_bin="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
  local link="$(brew --prefix)/bin/code"

  if [[ ! -f "$bundle_bin" ]]; then
    log_error "Could not find 'code' binary inside the VS Code app bundle."
    return 1
  fi

  if [[ -L "$link" ]] && [[ "$(readlink "$link")" == "$bundle_bin" ]]; then
    log_ok "'code' CLI already linked."
    return
  fi

  log_info "Linking 'code' CLI to $(brew --prefix)/bin..."
  ln -sf "$bundle_bin" "$link"
  log_ok "'code' CLI available — run 'code .' to open a folder."
}
