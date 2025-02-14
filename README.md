# Dotfiles

## Overview
This repository contains the configuration files (dotfiles) for setting up my macOS development environment. It includes settings for Zsh, Oh My Zsh, Git, VSCode, and Homebrew, making system setup seamless and reproducible.

## Features
- **Zsh & Oh My Zsh**
  - Custom `.zshrc` and `.zsh_aliases` with aliases and environment settings
  - `zsh-autosuggestions` and `zsh-syntax-highlighting` plugins
- **Git Configuration**
  - `.gitconfig` for global settings
- **VSCode Configuration**
  - `settings.json` and `keybindings.json`
  - Automatic installation of extensions
- **Vim Configuration**
  - Vim dotfiles management
- **Homebrew Package Management**
  - `Brewfile` to install CLI tools and apps
- **Automated Setup Script**
  - `install.sh` for easy installation on a new system

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
- Start a new **ZSH session**

## Updating Brewfile
To update the list of installed Homebrew packages:
```sh
brew bundle dump --file=~/dotfiles/brew/Brewfile --force --describe
```

## Updating VSCode Extensions
To save your installed extensions:
```sh
code --list-extensions > ~/dotfiles/vscode/extensions.txt
```
