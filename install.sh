#!/bin/bash
set -e  # Exit on error

echo "🚀 Installing dotfiles and configuring macOS..."
echo "----------------------------------------------"

# Step 1: Symlink dotfiles using Stow
echo "🔗 Symlinking dotfiles..."
echo "----------------------------------------------"
cd "$HOME/dotfiles"
stow --target=$HOME git vim vscode zsh iterm2 fonts
echo "✅ Dotfiles applied."
echo ""

# Step 2: Install Oh My Zsh Plugins
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

# Step 3: Restore VSCode Extensions
echo "🖥️ Installing VSCode extensions..."
echo "----------------------------------------------"
if [ -f "$HOME/dotfiles/vscode/extensions.txt" ]; then
    cat "$HOME/dotfiles/vscode/extensions.txt" | xargs -L 1 code --install-extension
    echo "✅ VSCode extensions installed."
else
    echo "⚠️ No VSCode extensions file found! Skipping."
fi
echo ""

# Step 4: Copy Fonts
echo "🔤 Copying fonts to ~/Library/Fonts/..."
echo "----------------------------------------------"
mkdir -p "$HOME/Library/Fonts"
cp -r "$HOME/dotfiles/fonts/"* "$HOME/Library/Fonts/"
echo "✅ Fonts installed."
echo ""

# Step 5: Apply iTerm2 Preferences
echo "🖥️ Applying iTerm2 preferences..."
echo "----------------------------------------------"
if [ -f "$HOME/dotfiles/iterm2/com.googlecode.iterm2.plist" ]; then
    stow --target=$HOME/Library/Preferences iterm2
    echo "✅ iTerm2 preferences applied."
else
    echo "⚠️ No iTerm2 preferences found! Skipping."
fi
echo ""

# Step 6: Restart Zsh session
echo "🎉 Setup complete! Restarting Zsh session..."
echo "----------------------------------------------"
exec zsh
