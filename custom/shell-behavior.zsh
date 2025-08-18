# Fix time drift in WSL
if [[ "$(uname -s)" == "Linux" ]]; then
  sudo nohup watch -n 10 ntpdate time.windows.com > /dev/null 2>&1 &
fi

# set 'nvm current' correctly when opening a shell in a dir containing .nvmrc
if [ -f "./.nvmrc" ] && nvm &> /dev/null; then
  nvm use --silent
fi