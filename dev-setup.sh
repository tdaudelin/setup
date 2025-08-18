#!/usr/bin/env bash

# Source library files
CMD="$0"
SCRIPT_DIR="$(cd "$(dirname "${CMD}")" && pwd -P)"
for f in $SCRIPT_DIR/library/*.sh; do
  source $f
done

# Where the magic happens
main(){
    echo "Please enter your password for sudo"
    sudo echo "Su-done"

    # We might need this if the script takes too long too download
    # while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    # read -p "Enter Team Bitbucket Slugs: " TEAM_SLUG

    # Add multi selection for tools to be installed
        # node
        # maven
        # gradle
        # java
        # groovy (would also include java)
        # javascript

    # Are you a front end engineer?

    # Yes or No?

    # (If yes, multi selection for tools);
        # React
        # grunt-cli
        # some other crazy front end dependency

    # Are you an engineer that might have to deal with AWS?

    local readonly os="$(which_os)"
    echo "Detected $os OS"
    echo "Do you want to start the script?"
    read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

    # Spawn a child process or shell to start downloading applications like Intellij, VSCode
    # Spawn a child process for other cli commands that we can run that aren't
    #           related to homebrew, git, sdkman or development tools

    if [[ "$os" == "mac" ]]; then
      mac_osx_setup
      homebrew_setup
      casks_setup
    elif [[ "$os" == "linux" ]]; then
      linux_setup
    else
      print_warn "No OS-specific setup defined for $os OS"
    fi

    setup_zsh

    # Setup Git
    git_setup

    # After git setup, spawn a child process to download all repos of provided slugs, accept a comma sep. list

    # Install Java and other JDK ecosystem tech
    java_setup

    # Install nvm and node tools
    node_setup

    # Install python 3 and tools
    python_setup

    # # Setup
    # ops_tools_setup

    exit 0
}

# Traps
finish(){
  print_header "Please close and reopen your terminal"
}
trap finish EXIT

main "$@"
