# If you come from Bash, you might need to adjust your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set the theme
ZSH_THEME="robbyrussell"

# Set a list of themes to pick from randomly
# ZSH_THEME_RANDOM_CANDIDATES=("robbyrussell" "agnoster")

# Uncomment to enable case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment to enable hyphen-insensitive completion
# HYPHEN_INSENSITIVE="true"

# Auto-update behavior
# Uncomment one of the following lines to configure it:
# zstyle ':omz:update' mode disabled  # Disable updates
# zstyle ':omz:update' mode auto      # Auto-update
# zstyle ':omz:update' mode reminder  # Show reminder

# Uncomment to change how often to auto-update (in days)
# zstyle ':omz:update' frequency 13

# Uncomment if pasting URLs and other text is messed up
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment to disable colors in `ls`
# DISABLE_LS_COLORS="true"

# Uncomment to disable auto-setting terminal title
# DISABLE_AUTO_TITLE="true"

# Uncomment to enable command auto-correction
# ENABLE_CORRECTION="true"

# Uncomment to display red dots while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment to disable marking untracked files under VCS as dirty
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment to change the command execution timestamp format
# HIST_STAMPS="mm/dd/yyyy"

# Set custom folder for Oh My Zsh
# ZSH_CUSTOM=/path/to/new-custom-folder

# Load plugins
plugins=(
    kubectl
    kube-ps1
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Configure right prompt to show Kubernetes context
RPROMPT='$(kube_ps1)'

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# User configuration

# Uncomment to manually set your language environment
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

# History configuration

HISTFILE=~/.zsh_history
HISTSIZE=50000   # Max number of commands in memory
SAVEHIST=10000   # Max number of commands stored in the history file

# Improve history behavior
setopt HIST_IGNORE_ALL_DUPS   # Remove older duplicate entries
setopt HIST_IGNORE_DUPS       # Prevent consecutive duplicates
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate commands to history
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first
setopt HIST_IGNORE_SPACE      # Ignore commands that start with a space
setopt HIST_REDUCE_BLANKS     # Remove extra whitespace
setopt HIST_VERIFY            # Require confirmation before execution
setopt SHARE_HISTORY          # Share history across sessions
setopt INC_APPEND_HISTORY     # Append history in real-time

# Prevent history file corruption
setopt EXTENDED_HISTORY  # Save timestamps for each command
setopt APPEND_HISTORY    # Append instead of overwriting history
setopt HIST_NO_STORE     # Prevent 'history' command from being stored

