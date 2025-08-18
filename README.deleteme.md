# Modern Machine Software Engineer Dev Setup

A collection of startup scripts to quickly setup a Modern Machine Engineer development laptop.

<!-- GETTING STARTED -->
## Getting Started
___

### Prerequisites
* Access to Bitbucket
* A terminal with a shell enviroment

### Installation

On a Mac, no installation needed.
Installation coming for Windows.

<!-- USAGE EXAMPLES -->
## Usage
___
```
$ chmod +x dev-setup.sh
$ ./dev-setup.sh
```

## Breakdown of files
http://sourabhbajaj.com/mac-setup/

___
For now the script is segemented into separate files to allow for easier development until we get closer to a more final script.
In the future, it might be awesome if everything is in a single file that is ran with a curl command wrapped in a shell command, e.g:

```
/bin/bash -c "$(curl -fsSL https://github.com/tdaudelin/home-folder/blob/master/setup/dev-setup.sh)"
```

[dev-setup.sh](https://example.com) - Main script to take in all user input and facilitate install applications based on input

[library/credentials.sh](https://example.com) - this has yet to be implemented but the idea is to rely on the [unix password store](https://www.passwordstore.org/) to prevent leaking of credentials to ENV variables

[library/mac-osx-lib.sh](https://example.com) - Functionality to get mac osx ready for developemnt (install xcode, show hidden files, etc.)

[library/homebrew-lib.sh](https://example.com) - Functionality to install/upgrade homebrew and install common packages (bash, gpg, wget)

[library/git-lib.sh](https://example.com) - Functionality to setup git on the local asset with correct settings, upgrade default git version on macs

[library/bitbucket-lib.sh](https://example.com) - Contains the functions to download repos through the bitbucket REST api

[library/sdkman-lib.sh](https://example.com) - Functionality around sdkman to setup jvm languages and their build tools

[library/nvm-js-lib.sh](https://example.com) - Functionality around installing nvm to setup a javascript developemnt environment

[library/python-lib.sh](https://example.com) - Functionality to setup a python developemnt environment with common packages

[library/docker-lib.sh](https://example.com) - Functionality to download and setup docker on Mac OS X

[library/frontend-lib.sh](https://example.com) - Functionality to download common frontend dependencies (grunt, jekyll, etc.)

[library/ops-tool.sh](https://example.com) - Functionality to download operations tools (AWS Cli, azure, etc.)

[library/util.sh](https://example.com) - Utility functions that are common to other scripts

[library/variables](https://example.com) - File where all urls, package versions are stored for easy updating

        
## Dev Automation Script Ideas/Stream of consciousness
___
- Change shell to zsh (?)
- Sections for Frontend engineer, backend engineers, devops, support
- Create an accepted file structure so we can all use the same simplified paths across scripts
- Update git, curl, etc that are bundled with MacOSX
- download xcodes (look into if this can be automated)
- Setup ssh with Bitbucket
- automate pulling all repos from bit bucket using a Projects 'slug'
- automate SDKman to download jdks, java, groovy, maven, gradle, ant, grails (if applicable)
- automate NVM to download 
- download dockerCE
- Setup ~/.artifactory properties, .m2/setup.xml, .gradle/gradle.properties
- Setup global gitignore files
- Start download of Intellij, VSCode, sublime, atom, iterm2 (allow users to choose)
- Allow known quality of life improvements to ~/.profile for shell customization
- One of the SecOps engineers recommending using https://www.passwordstore.org/ to limit leaking of user credentials to ENV variables.
- Download openshift cli tool
- brew completeion tools for downloaded applications (gradle, docker, vagrant, etc.)

Allow defaults but maybe allow teams to provide property files with common versions for their projects build tools.