function java_setup() {
  # Check to see if sdkman is already installed

  print_header "Java"
  print_info "Verifying sdkman..."
  if sdk version &> /dev/null; then
    print_info "sdkman already installed"
  else
    print_warn "sdkman not found. Installing..."
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
  fi

  sdk version

  if command_exists java && java -version &> /dev/null; then
    print_info "java already installed."
    java -version
  else
    print_warn "java not found. Installing..."
    sdk install java 11.0.16-tem
    sdk default java 11.0.16-tem
  fi
  # sdk install groovy
  # sdk install maven
  # sdk install gradle
  # sdk install groovyserv
  # sdk install ant
  # sdk install java 11.0.2-open
}
