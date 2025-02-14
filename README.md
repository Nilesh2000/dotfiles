# Dotfiles Setup

## Overview
This repository contains the configuration files (dotfiles) for setting up a macOS development environment. It includes settings for Zsh, Oh My Zsh, Git, VSCode, and Homebrew, making system setup seamless and reproducible.

## Features
- **Zsh & Oh My Zsh**
  - Custom `.zshrc` and `.zsh_aliases` with aliases and environment settings
  - `zsh-autosuggestions` and `zsh-syntax-highlighting` plugins
- **Git Configuration**
  - `.gitconfig` for global settings
- **VSCode Configuration**
  - `settings.json` and `keybindings.json`
  - Automatic installation of extensions
- **Homebrew Package Management**
  - `Brewfile` to install CLI tools and apps
- **Automated Setup Script**
  - `install.sh` for easy installation on a new system

## Installation
### 1. Clone the repository
```sh
cd ~
git clone https://github.com/Nilesh2000/dotfiles.git
cd dotfiles
```

### 2. Make the installation script executable
```sh
chmod +x install.sh
```

### 3. Run the setup script
```sh
./install.sh
```

This script will:
- Install **Xcode Command Line Tools**
- Install **Homebrew** and packages from `Brewfile`
- Install **Oh My Zsh** and necessary plugins
- Symlink dotfiles using **stow**
- Restore **VSCode settings and extensions**
- Start a new **Zsh session**

## Managing Dotfiles
To apply changes manually:
```sh
stow --target=$HOME zsh
stow --target=$HOME git
stow --target=$HOME vscode
```

To remove symlinks:
```sh
stow -D zsh
stow -D git
stow -D vscode
```

## Updating Brewfile
To update the list of installed Homebrew packages:
```sh
brew bundle dump --file=~/dotfiles/brew/Brewfile --force
```

## Updating VSCode Extensions
To save your installed extensions:
```sh
code --list-extensions > ~/dotfiles/vscode/extensions.txt
```

## Notes
- Ensure you have `stow` installed via Homebrew (`brew install stow`).
- Modify `.zshrc` or `Brewfile` as needed to customize your environment.

## License
MIT License. Feel free to modify and use this setup!
