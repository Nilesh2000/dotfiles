#!/bin/bash
set -e  # Exit on error

echo "🚀 Installing dotfiles and configuring macOS..."
echo "----------------------------------------------"

# Step 1: Remove default .zshrc if created by Oh My Zsh
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    echo "⚠️ Removing default .zshrc created by Oh My Zsh..."
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
    echo "✅ Backup created: ~/.zshrc.backup"
fi

# Step 2: Symlink Home Directory Dotfiles
echo "🔗 Symlinking home directory dotfiles..."
echo "----------------------------------------------"
cd "$HOME/dotfiles"
stow --target=$HOME git vim zsh

echo "✅ Git, Vim, and Zsh dotfiles applied."
echo ""

# Step 3: Symlink Application-Specific Dotfiles (Excluding extensions.txt)
echo "🔗 Symlinking application-specific dotfiles..."
echo "----------------------------------------------"

# ✅ VSCode settings (Only settings.json & keybindings.json, NOT extensions.txt)
mkdir -p "$HOME/Library/Application Support/Code/User"
stow --target="$HOME/Library/Application Support/Code/User" --ignore='extensions.txt' vscode
echo "✅ VSCode settings applied."
echo ""

# ✅ iTerm2 preferences
mkdir -p "$HOME/Library/Preferences"
stow --target="$HOME/Library/Preferences" iterm2
echo "✅ iTerm2 preferences applied."
echo ""

# Step 4: Install Oh My Zsh Plugins
echo "🔌 Installing Oh My Zsh plugins..."
echo "----------------------------------------------"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    echo "✅ zsh-autosuggestions installed."
else
    echo "✅ zsh-autosuggestions already installed."
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    echo "✅ zsh-syntax-highlighting installed."
else
    echo "✅ zsh-syntax-highlighting already installed."
fi
echo ""

# Step 5: Restore VSCode Extensions
echo "🖥️ Installing VSCode extensions..."
echo "----------------------------------------------"
if [ -f "$HOME/dotfiles/vscode/extensions.txt" ]; then
    cat "$HOME/dotfiles/vscode/extensions.txt" | xargs -L 1 code --install-extension
    echo "✅ VSCode extensions installed."
else
    echo "⚠️ No VSCode extensions file found! Skipping."
fi
echo ""

# Step 6: Install Fonts
echo "🔤 Installing fonts..."
echo "----------------------------------------------"
mkdir -p "$HOME/Library/Fonts"
cp -r "$HOME/dotfiles/fonts/"* "$HOME/Library/Fonts/"
echo "✅ Fonts installed."
echo ""

# Step 7: Restart Zsh session
echo "🎉 Setup complete! Restarting Zsh session..."
echo "----------------------------------------------"
exec zsh
