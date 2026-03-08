function install_emacs() {
  print_info "Verifying emacs..."
  if command_exists emacs; then
    print_info "emacs already installed"
  else
    print_warn "emacs not found. Installing..."
    # cask for mac port of emacs
    brew tap railwaycat/emacsmacport
    brew install --cask emacs-mac
    # spacemacs
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
    # SourceCodePro font for spacemacs
    brew tap homebrew/cask-fonts
    brew install --cask font-source-code-pro
  fi
}

function casks_setup() {
  print_header "Casks"
  print_info "Installing various tools and casks..."

  # would be nice to make this interactive so I can check from a list vs install all
  brew install awscli
  brew install jq
  brew install mise
  brew install --cask \
      docker \
      jetbrains-toolbox \
      mongodb-compass \
      insomnia \
      visual-studio-code

      # removed casks....
      # google-cloud-sdk \
      # google-chrome # uncomment if needed, usually already installed and will error if found
  # install_emacs
}
