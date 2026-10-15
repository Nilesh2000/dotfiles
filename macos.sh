#!/bin/bash
set -euo pipefail

defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

mkdir -p ~/Desktop/screenshots
defaults write com.apple.screencapture location ~/Desktop/screenshots

defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

defaults write com.apple.menuextra.clock ShowSeconds -bool true

killall SystemUIServer ControlCenter 2>/dev/null || true
echo "macOS defaults applied. Log out and back in for key repeat to take effect."
