# Mac Setup

Interactive checklist installer for a fresh macOS machine.

## Quickstart

Open **Terminal** and run:

```zsh
curl -fsSL https://raw.githubusercontent.com/tdaudelin/setup/main/bootstrap.sh | zsh
```

The bootstrap script will:

1. Check for `git` — if missing, it will prompt you to install **Xcode Command Line Tools** and exit. Once the installation completes, re-run the same `curl` command.
2. Clone this repo to `~/.setup` (or pull the latest if it already exists).
3. Launch the interactive setup menu.

## What can be installed

| Tool | Description |
|------|-------------|
| Oh My Zsh | Framework for managing zsh configuration |
| Homebrew | Package manager for macOS |
| git | Latest git from Homebrew (replaces outdated macOS default) |
| mise-en-place | Polyglot runtime version manager (replaces nvm, pyenv, etc.) |
| Visual Studio Code | Code editor by Microsoft |
| Insomnia | REST / GraphQL API client |
| JetBrains Toolbox | Launcher and updater for JetBrains IDEs |
| Docker Desktop | Containerisation platform |
| AWS CLI | Command-line interface for Amazon Web Services |
| Azure CLI | Command-line interface for Microsoft Azure |
| Google Cloud CLI | Command-line interface for Google Cloud Platform |
| jq | Lightweight command-line JSON processor |

## Menu controls

| Key | Action |
|-----|--------|
| `↑` / `↓` | Move cursor |
| `space` | Toggle selection |
| `a` | Toggle all |
| `enter` | Install selected |
| `q` | Quit without installing |

## Re-running

The bootstrap script is safe to re-run at any time. It will pull the latest version of the repo before launching the menu, and each installer is idempotent — already-installed tools will be updated rather than reinstalled.
