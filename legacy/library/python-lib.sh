function install_pyenv_macos() {
  brew update
  brew install openssl readline sqlite3 xz zlib
  brew install pyenv
}

function install_pyenv_linux() {
  sudo apt-get update
  sudo apt-get install --no-install-recommends -y make \
      build-essential \
      libssl-dev \
      zlib1g-dev \
      libbz2-dev \
      libreadline-dev \
      libsqlite3-dev \
      wget \
      curl \
      llvm \
      libncurses5-dev \
      xz-utils \
      tk-dev \
      libxml2-dev \
      libxmlsec1-dev \
      libffi-dev \
      liblzma-dev
  curl https://pyenv.run | bash
}

function python_setup() {
  print_header "Python"

  local readonly os="$(which_os)"
  print_info "Installing pyenv..."
  if [[ "$os" == "mac" ]]; then
    install_pyenv_macos
  elif [[ "$os" == "linux" ]]; then
    install_pyenv_linux
  else
    print_warn "Python installation on $os not yet supported"
  fi
  eval "$(pyenv init -)"
  pyenv --version

  print_info "Installing python..."
  pyenv install 3.9.2
  pyenv global 3.9.2
  pyenv version

  print_info "Installing python tooling..."
  pip install --upgrade pip
  pip install --upgrade setuptools
  pip install --user pipenv
  curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
  mkdir -p $(zsh_custom)/plugins/poetry
  poetry completions zsh > $(zsh_custom)/plugins/poetry/_poetry

  source $HOME/.poetry/env
  poetry config virtualenvs.in-project true
}