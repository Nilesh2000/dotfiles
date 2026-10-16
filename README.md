# dotfiles

My minimal macOS setup: shell, git, iTerm2, a few apps and a few macOS settings.
Apple Silicon Macs only.

## Setting up a new Mac

1. Connect to the internet and open the built-in **Terminal** app (Cmd+Space, type "Terminal").
2. Paste this and press Return:

   ```sh
   bash -c "$(curl -fsSL https://raw.githubusercontent.com/Nilesh2000/dotfiles/main/install.sh)"
   ```

3. Answer the prompts as they appear. It takes 10 to 20 minutes.
   - A dialog asks to install the **Xcode Command Line Tools**: click Install and wait.
   - Homebrew asks for your **Mac password** and a **Return** to continue.
4. When it prints `Done`, **log out and back in** (this makes the faster key repeat take effect).
5. Open **iTerm2** (not Terminal). It should have a pure black background.
   If it doesn't, go to Settings → Profiles, pick "Pure Black" and click "Set as Default".
6. In iTerm2, log in to GitHub:

   ```sh
   gh auth login
   ```

   Choose **GitHub.com**, then **SSH**, and let it create and upload a new key.
7. Optional, to push changes to this repo over SSH:

   ```sh
   git -C ~/dotfiles remote set-url origin git@github.com:Nilesh2000/dotfiles.git
   ```

8. Open **Docker Desktop** once to finish its own first-run setup.
9. Open **Switch** (the Cmd+Tab window switcher) and allow **Accessibility** and **Screen Recording** when macOS asks (System Settings → Privacy & Security). macOS doesn't let a script grant these for you.

That's it. You can re-run the script from step 2 at any time: it is safe to repeat.
If one install step fails, it warns and carries on, so just run it again later.

## What it does

- Installs Xcode Command Line Tools, Homebrew and Oh My Zsh.
- Installs everything in `brew/Brewfile`.
- Links the config files into your home folder (existing files are kept as `<name>.bak.<timestamp>`).
- Loads the iTerm2 profile and sets it as default.
- Applies the macOS settings in `macos.sh`.

## What's in the repo

| Path | What |
|---|---|
| `install.sh` | The one script that does everything above |
| `zsh/` | `.zshrc` (Oh My Zsh, robbyrussell theme, fzf, zoxide, atuin) and `.zsh_aliases` |
| `git/.gitconfig` | Git settings, with delta for diffs |
| `iterm2/pure-black.json` | iTerm2 profile: black background, Catppuccin colors, Nerd Font, Cmd/Opt key bindings |
| `brew/Brewfile` | CLI tools and apps to install |
| (in `install.sh`) | Switch hotkeys: Option+Tab for all windows, Option+\` for the current app |
| `macos.sh` | Key repeat, screenshots folder, battery percentage, clock with seconds, Dock auto-hide with no slide, no hot corners, Finder extensions/path bar/hidden files/list view, no window animations, no smart quotes or auto-correct, key hold repeats, PNG screenshots without shadow, no `.DS_Store` on network/USB drives, no Spotlight menu bar icon, Touch ID for sudo |

## Changing things later

The config files are symlinks into `~/dotfiles`, so editing `~/.zshrc`, `~/.zsh_aliases` or `~/.gitconfig` edits the repo. Then:

```sh
cd ~/dotfiles && git add -A && git commit -m "message" && git push
```

- **New app or tool:** add a line to `brew/Brewfile`.
- **New macOS setting:** add it to `macos.sh`.
