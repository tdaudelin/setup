function homebrew_setup() {
  print_header "Homebrew"
  print_info "Verifying brew... "
  if command_exists brew; then
    print_info "brew is already installed"
  else
    print_warn "brew is not installed. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  print_info "updating and upgrading brew..."
  brew update && brew upgrade

  # Install GNU core utilities (those that come with OS X are outdated).
  # Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
  # brew install coreutils
  # sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

  # brew install bash
  # brew install bash-completion2

  # brew install gpg

  # brew install wget

  # # We installed the new shell, now we have to activate it
  # echo "Adding the newly installed shell to the list of allowed shells"
  # # Prompts for password
  # sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
  # # Change to the new shell, prompts for password
  # chsh -s /usr/local/bin/bash

  # Install `wget` with IRI support.
  # brew install wget --with-iri
}
