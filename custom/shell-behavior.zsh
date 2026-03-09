# Fix time drift in WSL
if [[ "$(uname -s)" == "Linux" ]]; then
  sudo nohup watch -n 10 ntpdate time.windows.com > /dev/null 2>&1 &
fi
