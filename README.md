# Dotfiles

## Overview
This repository contains the dotfiles for setting up my macOS development environment from scratch. It includes settings for my Fonts, Git, Homebrew, Vim, VSCode, ZSH, and iTerm2, making system setup seamless and reproducible.

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
  - Automatically loaded by iTerm2
- **Fonts Management**
  - Custom fonts stored in `dotfiles/fonts/`
  - Automatically copied to `~/Library/Fonts/` during setup
- **Automated Setup Scripts**
  - **`bootstrap.sh`** for installing system dependencies (Xcode CLI, Homebrew, Git, Stow, and Oh My Zsh)
  - **`install.sh`** for symlinking dotfiles and applying configurations
  - Idempotent installation (safe to run multiple times)

## Installation
### **Step 1: Bootstrap the System**
Use `curl` to fetch the script and run it:
```sh
source <(curl -fsSL https://raw.githubusercontent.com/Nilesh2000/dotfiles/main/bootstrap.sh)
```
This script will:
- Install **Xcode Command Line Tools**
- Install **Homebrew** and packages
- Install **Git**
- Install **Stow** for dotfile management
- Install **Oh My Zsh**
- Clone the **dotfiles repository**

### **Step 2: Apply Dotfiles**
Once the bootstrap script completes, run:
```sh
cd ~/dotfiles
./install.sh
```
This script will:
- Symlink dotfiles using **Stow**
- Restore **VSCode settings and extensions**
- Install **Oh My Zsh plugins**
- Copy **fonts to `~/Library/Fonts/`**
- Apply **iTerm2 preferences**
- Restart the **Zsh session**

## Maintenance
### **Updating Brewfile**
To update the list of installed Homebrew packages:
```sh
brew bundle dump --file=~/dotfiles/brew/Brewfile --force --describe
```

### **Managing VSCode Extensions**
To save your installed extensions:
```sh
code --list-extensions > ~/dotfiles/vscode/extensions.txt
```

### **Managing Fonts**
To update or install new fonts:
1. Add new font files (`.ttf`, `.otf`) to `~/dotfiles/fonts/`
2. Run:
   ```sh
   cp -r ~/dotfiles/fonts/* ~/Library/Fonts/
   ```

### **Managing iTerm2 Preferences**
To sync iTerm2 settings across machines:
1. Ensure iTerm2 loads preferences from the dotfiles directory:
   - **iTerm2 → Preferences → General**
   - Check ✅ **“Load preferences from a custom folder”**
   - Set the path to `~/dotfiles/iterm2/`
2. Symlink iTerm2 preferences:
   ```sh
   stow --target=$HOME/Library/Preferences iterm2
   ```

## Contributing
Feel free to fork this repository and customize it for your needs. Pull requests for improvements are welcome!
