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
  brew install svn # needed for Source Code Pro font install for Spacemacs
  # would be nice to make this interactive so I can check from a list vs install all
  brew install awscli
  brew install jq
  brew install --cask docker \
      google-cloud-sdk \
      jetbrains-toolbox \
      mongodb-compass \
      postman \
      visual-studio-code
      # google-chrome # uncomment if needed, usually already installed and will error if found
  install_emacs
}
