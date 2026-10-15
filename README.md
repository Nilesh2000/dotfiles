# dotfiles

Minimal macOS setup: shell, git, iTerm2, Homebrew apps and a few macOS defaults.

## New laptop

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Nilesh2000/dotfiles/main/install.sh)"
```

Then run `gh auth login` (choose SSH) and open a new iTerm2 window.

The repo lives at `~/dotfiles`. Re-running `install.sh` is safe. Existing config files are kept as `<name>.bak.<timestamp>`.

## What's in it

| Path | What |
|---|---|
| `zsh/` | `.zshrc` (Oh My Zsh, robbyrussell, fzf, zoxide, atuin) and `.zsh_aliases` |
| `git/.gitconfig` | git settings with delta |
| `iterm2/pure-black.json` | iTerm2 profile: pure black, Catppuccin colors, Nerd Font, Cmd/Opt key bindings |
| `brew/Brewfile` | CLI tools and apps |
| `macos.sh` | key repeat, screenshots folder, battery percentage |

## Keeping it up to date

Config files are symlinked, so edit `~/.zshrc` etc. directly and commit from `~/dotfiles`.
New app or tool: add it to `brew/Brewfile`.
