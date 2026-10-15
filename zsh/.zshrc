[ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(zsh-autosuggestions zsh-syntax-highlighting)

export GOPATH="$HOME/go"
export PATH="$HOME/.local/bin:$PATH"

source $ZSH/oh-my-zsh.sh

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS HIST_VERIFY HIST_NO_STORE
setopt SHARE_HISTORY EXTENDED_HISTORY

source <(fzf --zsh)
eval "$(zoxide init zsh)"
eval "$(atuin init zsh --disable-up-arrow)"  # after fzf so atuin owns Ctrl+R

export BAT_THEME="base16"
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8,fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc,marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases
