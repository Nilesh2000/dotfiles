#!/bin/bash
set -e  # Exit on error

echo ""
echo "🚀 Bootstrapping macOS environment..."
echo "----------------------------------------------"
echo ""

# Step 1: Ask for sudo password once
echo "🔑 Requesting sudo access..."
echo "----------------------------------------------"
if ! sudo -v; then
    echo "❌ Failed to get sudo access. Exiting."
    exit 1
fi
echo "✅ Sudo access granted."
echo ""

# Keep sudo alive
while true; do sudo -n true; sleep 60; done 2>/dev/null &

# Step 2: Install Xcode Command Line Tools
echo "🛠 Checking for Xcode Command Line Tools..."
echo "----------------------------------------------"
if ! xcode-select --print-path &>/dev/null; then
    echo "🔄 Installing Xcode Command Line Tools..."
    sudo xcode-select --install
    until xcode-select --print-path &>/dev/null; do sleep 5; done
    echo "✅ Xcode Command Line Tools installed."
else
    echo "✅ Xcode Command Line Tools already installed."
fi
echo ""

# Step 3: Install Homebrew
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

# Step 4: Install Git
echo "🔄 Checking for Git..."
echo "----------------------------------------------"
if ! command -v git &> /dev/null; then
    echo "🔄 Installing Git..."
    brew install git
    echo "✅ Git installed."
else
    echo "✅ Git is already installed."
fi
echo ""

# Step 5: Install Stow (for dotfile management)
echo "🔄 Checking for Stow..."
echo "----------------------------------------------"
if ! command -v stow &> /dev/null; then
    echo "🔄 Installing Stow..."
    brew install stow
    echo "✅ Stow installed."
else
    echo "✅ Stow is already installed."
fi
echo ""

# Step 6: Install Oh My Zsh
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

# Step 7: Clone Dotfiles Repository
echo "📂 Checking for dotfiles repository..."
echo "----------------------------------------------"
if [ ! -d "$HOME/dotfiles" ]; then
    echo "🔄 Cloning dotfiles repository..."
    git clone git@github.com:Nilesh2000/dotfiles.git "$HOME/dotfiles"
    echo "✅ Dotfiles repository cloned."
else
    echo "✅ Dotfiles repository already exists."
fi
echo ""

# Step 8: Change to dotfiles directory
echo "📂 Changing into dotfiles directory..."
cd "$HOME/dotfiles"
echo "✅ Now inside dotfiles directory."
echo ""

echo "✅ Bootstrap complete! Now run: ./install.sh"
