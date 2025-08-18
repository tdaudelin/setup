function setup_ohmyzsh() {
    print_info "Installing Oh My Zsh!..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    print_info "Copying custom scripts..."
    cp ~/setup/custom/* $(zsh_custom)

    print_info "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $(zsh_custom)/themes/powerlevel10k
}

function setup_mac_zsh() {
    brew install zsh
    sudo sh -c "echo $(which zsh) >> /etc/shells"
    chsh -s $(which zsh)
    setup_ohmyzsh
}

function setup_linux_zsh() {
    sudo apt install zsh
    chsh -s $(which zsh)
    setup_ohmyzsh
}

function setup_zsh() {
    print_header "ZSH"
    if [[ "$SHELL"=~"zsh" ]]; then
        print_info "zsh already installed"
    else
        print_warn "zsh not installed. Installing..."
        local readonly os="$(which_os)"

        if [[ "$os" == "mac" ]]; then
            setup_mac_zsh
        elif [[ "$os" == "linux" ]]; then
            setup_linux_zsh
        else
            print_warn "zsh setup for $os not supported"
        fi
    fi
}
