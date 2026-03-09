## Desires:
- Merge in README.deleteme.md to this file
- Separate out installation of tools like sdk, nvm, etc from installing java,  node, etc using those tools. Make installation optional and require confirmation

## Shell
### Oh My Zsh
https://github.com/ohmyzsh/ohmyzsh/wiki

If you get the "there are insecure directories" warning, run:

```
compaudit | xargs chmod g-w
```

#### Custom Configuration
Located in $ZSH_CUSTOM folder.
This is a great place to put any custom shell env vars / scripting / config as it is loaded on startup just like .zshrc.
Just create a new file e.g. <client_name>_custom.zsh and fill it with whatever is needed.

### Theme

* https://github.com/romkatv/powerlevel10k
* git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

## Git and Home Dir

Set up SSH access to personal github account

```
git config --global user.name "Travis Daudelin"
git config --global user.email "{work email}"
git config --global pull.rebase true
git config --global fetch.prune true
```

```
cd ~/
git init
git remote add origin git@github.com:tdaudelin/home-folder.git
git pull origin master --allow-unrelated-histories
```

## Editors

https://www.emacswiki.org/emacs/EmacsForMacOS

https://www.spacemacs.org/

https://www.jetbrains.com/toolbox-app/?fromMenu

https://code.visualstudio.com/

* Plugins
  * emmanuelbeziat.vscode-great-icons
  * lfs.vscode-emacs-friendly
  * eamodio.gitlens
  * msjsdiag.debugger-for-chrome
  * orta.vscode-jest
* https://code.visualstudio.com/docs/setup/mac


## SDKs

https://github.com/nvm-sh/nvm
```
# Install most recent NodeJS LTS and NPM
$ nvm install --lts
$ nvm use --lts
$ nvm install --latest-npm

# Configure NPM to use private Artifactory instead of public NPM registry
$ curl -u 'USERNAME:PASSWORD' AUTH_URL > ~/.npmrc # npm login --always-auth might also work (need to set registry first)
$ npm config set registry VIRTUAL_REGISTRY_URL

# Additional ~/.npmrc settings
$ npm config set save-exact true
$ npm config set engine-strict true
```

https://sdkman.io/

### Python 3
```
sudo apt install python3 python3-pip ipython3
sudo -H pip3 install -U pipenv
```

## Misc

https://github.com/rhyeal/aws-rotate-iam-keys

https://cli.vuejs.org/

https://sensible-side-buttons.archagon.net/

Setting up shortcuts to spaces
https://apple.stackexchange.com/a/213566

Avatar saved in MM Google Drive
