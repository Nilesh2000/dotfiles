#!/bin/bash
# Fresh Mac:  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Nilesh2000/dotfiles/main/install.sh)"
# Safe to re-run.
set -euo pipefail

REPO="https://github.com/Nilesh2000/dotfiles.git"
DOT="$HOME/dotfiles"

if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install
  until xcode-select -p >/dev/null 2>&1; do sleep 5; done
fi

if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

[ -d "$DOT/.git" ] || git clone "$REPO" "$DOT"

brew bundle --no-upgrade --file="$DOT/brew/Brewfile" || echo "WARNING: some Brewfile items failed; continuing. Re-run install.sh later."

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
for p in zsh-autosuggestions zsh-syntax-highlighting; do
  [ -d "$HOME/.oh-my-zsh/custom/plugins/$p" ] || \
    git clone "https://github.com/zsh-users/$p" "$HOME/.oh-my-zsh/custom/plugins/$p"
done

# link <repo file> <destination>; an existing real file is kept as <destination>.bak.<timestamp>
link() {
  local src="$DOT/$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  [ "$(readlink "$dest" 2>/dev/null)" = "$src" ] && return
  if [ -e "$dest" ] || [ -L "$dest" ]; then mv "$dest" "$dest.bak.$(date +%Y%m%d%H%M%S)"; fi
  ln -s "$src" "$dest"
}
link zsh/.zshrc "$HOME/.zshrc"
link zsh/.zsh_aliases "$HOME/.zsh_aliases"
link git/.gitconfig "$HOME/.gitconfig"
link iterm2/pure-black.json "$HOME/Library/Application Support/iTerm2/DynamicProfiles/pure-black.json"

# iTerm2 may overwrite these if it is running: quit it (Cmd+Q) and re-run if they do not stick
defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "6B1F0A52-CA77-4A11-9C3E-0000CA77M0CA"
defaults write com.googlecode.iterm2 ClickToSelectCommand -bool false
# Minimal theme (tabs blend into the terminal), tab bar only when 2+ tabs, no tab numbers
defaults write com.googlecode.iterm2 TabStyleWithAutomaticOption -int 5
defaults write com.googlecode.iterm2 HideTab -bool true
defaults write com.googlecode.iterm2 HideTabNumber -bool true

bash "$DOT/macos.sh"

cat <<'MSG'

Done. Manual steps left:
  1. gh auth login            (choose SSH; it can upload a new key)
  2. Open a new iTerm2 window
  3. Open Switch and allow Accessibility + Screen Recording
     (System Settings > Privacy & Security; macOS does not let scripts grant these)
MSG
