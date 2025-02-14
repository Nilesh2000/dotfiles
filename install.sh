#!/bin/bash

set -e  # Exit on error

echo ""
echo "🚀 Setting up your macOS system with dotfiles..."
echo "----------------------------------------------"
echo ""

# Step 1: Ask for sudo password once
echo ""
echo "🔑 Requesting sudo access..."
echo "----------------------------------------------"
if ! sudo -v; then
    echo "❌ Failed to get sudo access. Exiting."
    exit 1
fi
echo "✅ Sudo access granted."
echo ""

# Keep sudo alive during the script execution
while true; do sudo -n true; sleep 60; done 2>/dev/null &

# Step 2: Install Xcode Command Line Tools
echo ""
echo "🛠 Checking for Xcode Command Line Tools..."
echo "----------------------------------------------"
if ! xcode-select --print-path &>/dev/null; then
    echo "🔄 Installing Xcode Command Line Tools..."
    sudo xcode-select --install
    # Wait until installation is complete
    until xcode-select --print-path &>/dev/null; do sleep 5; done
    echo "✅ Xcode Command Line Tools installed."
else
    echo "✅ Xcode Command Line Tools already installed."
fi
echo ""

# Step 3: Install Homebrew (if missing)
echo ""
echo "🍺 Checking for Homebrew..."
echo "----------------------------------------------"
if ! command -v brew &> /dev/null; then
    echo "🔄 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo "✅ Homebrew installed."
else
    echo "✅ Homebrew is already installed."
fi
echo ""

# Step 4: Install dependencies via Brewfile
echo ""
echo "📦 Installing packages from Brewfile..."
echo "----------------------------------------------"
if [ -f "$HOME/dotfiles/brew/Brewfile" ]; then
    brew bundle --file="$HOME/dotfiles/brew/Brewfile"
    echo "✅ Brewfile packages installed."
else
    echo "⚠️ No Brewfile found! Skipping package installation."
fi
echo ""

# Step 5: Install Zsh & Oh My Zsh (if missing)
echo ""
echo "🐚 Checking for Oh My Zsh..."
echo "----------------------------------------------"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "🔄 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
    echo "✅ Oh My Zsh installed."
else
    echo "✅ Oh My Zsh is already installed."
fi
echo ""

# Step 6: Install Oh My Zsh plugins
echo ""
echo "🔌 Installing Oh My Zsh plugins..."
echo "----------------------------------------------"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "🔄 Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    echo "✅ zsh-autosuggestions installed."
else
    echo "✅ zsh-autosuggestions already installed."
fi
echo ""

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "🔄 Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    echo "✅ zsh-syntax-highlighting installed."
else
    echo "✅ zsh-syntax-highlighting already installed."
fi
echo ""

# Step 7: Clone dotfiles and use Stow to symlink configs
echo ""
echo "🔗 Symlinking dotfiles using stow..."
echo "----------------------------------------------"
cd "$HOME/dotfiles"

echo "🔄 Stowing brew..."
stow --target=$HOME brew
echo "✅ brew stowed."
echo ""

echo "🔄 Stowing git..."
stow --target=$HOME git
echo "✅ git stowed."
echo ""

echo "🔄 Stowing vim..."
stow --target=$HOME vim
echo "✅ vim stowed."
echo ""

echo "🔄 Stowing vscode..."
stow --target=$HOME vscode
echo "✅ vscode stowed."
echo ""

echo "🔄 Stowing zsh..."
stow --target=$HOME zsh
echo "✅ zsh stowed."
echo ""

# Step 8: Install Fonts
echo ""
echo "🔤 Installing fonts..."
echo "----------------------------------------------"
FONT_DIR="$HOME/Library/Fonts"

if [ -d "$HOME/dotfiles/fonts" ]; then
    echo "🔄 Copying fonts to $FONT_DIR..."
    cp -r ~/dotfiles/fonts/* "$FONT_DIR/"
    echo "✅ Fonts installed."
else
    echo "⚠️ No fonts directory found in dotfiles. Skipping."
fi
echo ""

# Step 9: Restore VSCode extensions
echo ""
echo "🖥️ Installing VSCode extensions..."
echo "----------------------------------------------"
if [ -f "$HOME/dotfiles/vscode/extensions.txt" ]; then
    cat "$HOME/dotfiles/vscode/extensions.txt" | xargs -L 1 code --install-extension
    echo "✅ VSCode extensions installed."
else
    echo "⚠️ No VSCode extensions file found! Skipping extension installation."
fi
echo ""

# Step 10: Restart Zsh session
echo ""
echo "🎉 Setup complete! Restarting Zsh session..."
echo "----------------------------------------------"
exec zsh
