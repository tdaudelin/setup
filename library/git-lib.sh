# TODO: refactor to use brew: https://medium.com/@katopz/how-to-upgrade-git-ff00ea12be18

function install_git() {
  local readonly os="$(which_os)"
  if [[ "$os" == "mac" ]]; then
    brew install git
    brew link --force git
  elif [[ "$os" == "linux" ]]; then
    sudo add-apt-repository ppa:git-core/ppa -y
    sudo apt-get update
    sudo apt-get install git -y
  else
    print_error "Unsupported OS: $os"
    exit 1
  fi
  # force rehash of $PATH to pick up new git executable
  hash -r
  print_info "Installed Git $(git --version)"
}

function configure_git() {
  read -p "Enter your name as you would like it to appear in git: " gitName
  read -p "Enter your work email: " email

  git config --global user.name "$gitName"
  git config --global user.email "$email"
  git config --global pull.rebase true
  git config --global fetch.prune true
  if [[ $(which_os) == 'mac' ]]; then
    git config --global credential.helper osxkeychain
  fi

  print_info "Global git config values set:"
  cat ~/.gitconfig
}

# Setup git
function git_setup() {
  print_header "Git"
  print_info "Verifying git..."
  if command_exists git; then
    local readonly gitVersionStr=$(git --version)
    local readonly gitVersion="${gitVersionStr#"git version "}"
    local readonly gitVersionMajor=$(echo "$gitVersion" | awk -F \. {'print $1'})
    local readonly gitVersionMinor=$(echo "$gitVersion" | awk -F \. {'print $2'})

    # Minimum git version: 2.30.x
    if [[ $gitVersionMajor -lt 2 || $gitVersionMajor -eq 2 && $gitVersionMinor -lt 30 ]]; then
      print_warn "Git ($gitVersion) is lower than desired. Updating..."
      install_git
    else
      print_info "Git ($gitVersion) is already installed"
    fi
  else
    print_warn "Git is not installed. Installing..."
    install_git
  fi

  configure_git
}