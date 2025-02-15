# Dotfiles

## Overview
This repository contains the dotfiles for setting up my macOS development environment from scratch. It includes settings for my Fonts, Git, Homebrew, Vim, VSCode, ZSH making system setup seamless and reproducible.

## Prerequisites
- macOS operating system
- Terminal access
- Internet connection

## Features
- **Zsh & Oh My Zsh**
  - Custom `.zshrc` and `.zsh_aliases` with aliases and environment settings
  - `zsh-autosuggestions` and `zsh-syntax-highlighting` plugins
  - Kubernetes context in prompt
  - Git-aware prompt
- **Git Configuration**
  - `.gitconfig` for global settings
  - Delta for enhanced diffs
  - Useful Git aliases
- **VSCode Configuration**
  - `settings.json` and `keybindings.json`
  - Automatic installation of extensions
  - Material theme and icons
- **Vim Configuration**
  - Syntax highlighting and line numbers
- **Homebrew Package Management**
  - `Brewfile` to install CLI tools and apps
- **iTerm2 Configuration**
  - Custom preferences stored in `com.googlecode.iterm2.plist`
  - Auto-symlinked via `stow`
- **Fonts Management**
  - Custom fonts stored in `dotfiles/fonts/`
  - Automatically copied to `~/Library/Fonts/` during setup
- **Automated Setup Script**
  - `install.sh` for easy installation on a new system
  - Idempotent installation (safe to run multiple times)

## Installation
Use `curl` to fetch the script and run it:
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Nilesh2000/dotfiles/main/install.sh)"
```

This script will:
- Install **Xcode Command Line Tools**
- Install **Homebrew** and packages from `Brewfile`
- Install `oh-my-zsh` and necessary plugins
- Symlink dotfiles using `stow`
- Restore **VSCode settings and extensions**
- Apply **iTerm2 preferences**
- Copy **custom fonts to `~/Library/Fonts/`**
- Start a new **ZSH session**

## Maintainenance
### Updating Brewfile
To update the list of installed Homebrew packages:
```sh
brew bundle dump --file=~/dotfiles/brew/Brewfile --force --describe
```

### Managing VSCode Extensions
To save your installed extensions:
```sh
code --list-extensions > ~/dotfiles/vscode/extensions.txt
```

### Managing Fonts
To update or install new fonts:
1. Add new font files (`.ttf`, `.otf`) to `~/dotfiles/fonts/`
2. Run:
   ```sh
   cp -r ~/dotfiles/fonts/* ~/Library/Fonts/
   ```

### Managing iTerm2 Preferences
To sync iTerm2 settings across machines:
```sh
stow --target=$HOME/Library/Preferences iterm2
```

## Contributing
Feel free to fork this repository and customize it for your needs. Pull requests for improvements are welcome!

