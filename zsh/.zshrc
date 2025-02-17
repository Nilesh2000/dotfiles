# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# ZSH_THEME_RANDOM_CANDIDATES=("robbyrussell" "agnoster")

# Uncomment to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment to use hyphen-insensitive completion.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled
# zstyle ':omz:update' mode auto
# zstyle ':omz:update' mode reminder

# Uncomment to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment to disable marking untracked files under VCS as dirty.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment to change the command execution timestamp format.
# HIST_STAMPS="mm/dd/yyyy"

# Set custom folder for Oh My Zsh.
# ZSH_CUSTOM=/path/to/new-custom-folder

# Load plugins.
plugins=(kubectl kube-ps1 zsh-autosuggestions zsh-syntax-highlighting)
RPROMPT='$(kube_ps1)'
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases
export PATH="$HOME/.bin:$PATH"
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

# History file location
HISTFILE=~/.zsh_history

SAVEHIST=10000
HISTSIZE=50000

# Improve history behavior
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# Prevent history file corruption
setopt EXTENDED_HISTORY
setopt APPEND_HISTORY
setopt HIST_NO_STORE

