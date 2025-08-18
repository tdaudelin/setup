# Setup Node, NVM, Javascript
function node_setup() {
  print_header "NodeJS"
  print_info "Verifying nvm..."
  if command_exists nvm; then
    print_info "nvm $(nvm --version) already installed"
  else
    print_warn "nvm not found. Installing..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    print_info "nvm $(nvm --version)"
  fi

  print_info "Verifying node..."
  if command_exists node; then
    print_info "node $(node --version) already installed"
  else
    print_warn "node not found. Installing..."
    nvm install --lts
    nvm install --latest-npm
  fi

  # # Configure NPM to use Artifactory instead of public NPM registry
  # curl -u 'USERNAME:PASSWORD' https://<on-prem artifactory domain>/artifactory/api/npm/auth > ~/.npmrc
  # npm config set registry https://<on-prem artifactory domain>/artifactory/api/npm/npm-virtual

  # # Additional ~/.npmrc settings
  # npm config set save-exact true

  # print_info "Installing Vue CLI..."
  # npm i -g @vue/cli
}
