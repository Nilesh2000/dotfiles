#!/bin/bash
set -euo pipefail

defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

mkdir -p ~/Desktop/screenshots
defaults write com.apple.screencapture location ~/Desktop/screenshots

defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

defaults write com.apple.menuextra.clock ShowSeconds -bool true

defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock show-recents -bool false
for c in tl tr bl br; do  # hot corners off
  defaults write com.apple.dock wvous-$c-corner -int 1
  defaults write com.apple.dock wvous-$c-modifier -int 0
done

defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXDefaultSearchScope -string SCcf

killall SystemUIServer ControlCenter Dock Finder 2>/dev/null || true

# Touch ID for sudo (asks for your password once)
if ! grep -qs '^auth.*pam_tid' /etc/pam.d/sudo_local; then
  sed 's/^#auth/auth/' /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local >/dev/null \
    || echo "WARNING: could not enable Touch ID for sudo; see README"
fi
echo "macOS defaults applied. Log out and back in for key repeat to take effect."
