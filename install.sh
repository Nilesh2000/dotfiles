#!/bin/bash

set -e  # Exit on error

echo "🚀 Setting up your macOS system with dotfiles..."

# Step 1: Ask for sudo password once
if ! sudo -v; then
    echo "❌ Failed to get sudo access. Exiting."
    exit 1
fi
# Keep sudo alive during the script execution
while true; do sudo -n true; sleep 60; done 2>/dev/null &

# Step 2: Install Xcode Command Line Tools
if ! xcode-select --print-path &>/dev/null; then
    echo "🛠 Installing Xcode Command Line Tools..."
    sudo xcode-select --install
    # Wait until installation is complete
    until xcode-select --print-path &>/dev/null; do sleep 5; done
    echo "✅ Xcode Command Line Tools installed."
fi

# Step 3: Install Homebrew (if missing)
if ! command -v brew &> /dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "✅ Homebrew is already installed."
fi

# Step 4: Install dependencies via Brewfile
if [ -f "$HOME/dotfiles/brew/Brewfile" ]; then
    echo "📦 Installing packages from Brewfile..."
    brew bundle --file="$HOME/dotfiles/brew/Brewfile"
else
    echo "⚠️ No Brewfile found! Skipping package installation."
fi

# Step 5: Install Zsh & Oh My Zsh (if missing)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "🐚 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
else
    echo "✅ Oh My Zsh is already installed."
fi

# Step 6: Install Oh My Zsh plugins
echo "🔌 Installing Oh My Zsh plugins..."
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    echo "✅ zsh-autosuggestions already installed."
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
    echo "✅ zsh-syntax-highlighting already installed."
fi

# Step 7: Clone dotfiles and use Stow to symlink configs
echo "🔗 Symlinking dotfiles using stow..."
cd "$HOME/dotfiles"
stow --target=$HOME zsh
stow --target=$HOME git
stow --target=$HOME vscode

# Step 8: Restore VSCode extensions
if [ -f "$HOME/dotfiles/vscode/extensions.txt" ]; then
    echo "🖥️ Installing VSCode extensions..."
    cat "$HOME/dotfiles/vscode/extensions.txt" | xargs -L 1 code --install-extension
else
    echo "⚠️ No VSCode extensions file found! Skipping extension installation."
fi

# Step 9: Restart Zsh session
echo "🎉 Setup complete! Starting a new Zsh session..."
exec zsh

