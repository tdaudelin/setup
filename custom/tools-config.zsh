# Uncomment the below lines to enable the tools you want to use

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# # Python
# export PIPENV_VENV_IN_PROJECT=1
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$HOME/.poetry/bin:$HOME/.local/bin:$PATH"
# # might need to have this line instead of the next if pyenv isn't initializing properly on first time setup
# # type pyenv &> /dev/null && eval "$(pyenv init -)" && eval "$(pyenv init --path)"
# type pyenv &> /dev/null && eval "$(pyenv init --path)"

# # SDKMAN!
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
