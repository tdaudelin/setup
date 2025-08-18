function verify_make() {
    print_info "Verifying make..."
    if command_exists make; then
        print_info "Make is installed: $(make --version | grep GNU)"
    else
        print_error "Make is required, install Xcode tools or your distribution's build tool package"
        exit 1
    fi
}

# Set Finder preferences
function configure_finder() {
    print_info 'configuring Finder'
    # Set desktop folder as default
    defaults write com.apple.finder NewWindowTarget -string "PfDe"
    # Always show hidden files
    defaults write com.apple.finder AppleShowAllFiles TRUE
    killall Finder
}

function mac_osx_setup() {
    # echo "------------------------------"
    # echo "Updating OSX.  If this requires a restart, run the script again."

    # Install all available updates
    # sudo softwareupdate -ia --verbose

    # Install only recommended available updates
    # sudo softwareupdate -ir --verbose

    print_header "MacOS Setup"
    print_info "Verifying Xcode command line tools"
    if command_exists xcode-select; then
        print_info "Xcode is installed: $(xcode-select --version)"
    else
        print_warn "Xcode is not installed. Installing..."
        xcode-select --install
    fi

    verify_make

    configure_finder
}
