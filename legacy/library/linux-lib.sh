function linux_setup() {
    print_header "Linux Setup"
    print_info "Installing updates..."
    sudo apt update && sudo apt -y upgrade
    # For correcting WSL time desync
    sudo apt-get install ntpdate -y
}