# If you come from bash you might have to change your $PATH.
export PATH=$PATH:$HOME/.local/bin:$HOME/bin:/usr/local/bin:$HOME/go/bin

export NVM_DIR="$HOME/.nvm"
# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Path to your oh-my-zsh installation.
export ZSH="/home/jeremy/.oh-my-zsh"

# Ansible exports
export ANSIBLE_NOCOWS=1

# For tmux session manager (tmuxp)
export DISABLE_AUTO_TITLE='true'
export TMUXP_CONFIGDIR="$HOME/.config/tmuxp/"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]
then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker docker-compose tmux kubectl-autocomplete)
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Git aliases
alias git-peek='git branch --merged remotes/origin/master | grep -v master | grep -v HEAD | grep "remotes/origin/" | cut -d/ -f3-'
alias git-rekt='git branch --merged remotes/origin/master | grep -v master | grep -v HEAD | grep "remotes/origin/" | cut -d/ -f3- | xargs -n1 git push -d origin'

# Docker aliases
alias docker-pkill='docker rm $(docker ps -aq)'
alias docker-merc='docker-pkill; docker rmi $(docker images -aq) --force'

# Project aliases
alias asu="cd ~/dev/personal/asu"
alias cac="cd ~/dev/personal/linux_cac"
alias create="cd ~/dev/work/create"
alias levelup="cd ~/dev/work/levelup"
alias senior="cd ~/dev/work/levelup/jjackson3"
alias cerebro="cd ~/dev/work/levelup/cerebro"
alias cerebro-api="cd ~/dev/work/cerebro && tmuxp load cerebro-api"
alias cerebro-frontend="cd ~/dev/work/cerebro && tmuxp load cerebro-frontend"
alias dotfiles="cd ~/dotfiles"
alias handbook="cd ~/dev/work/project-orko/content/en/handbook"
alias pers="cd ~/dev/personal/"
alias work="cd ~/dev/work/"
alias mentees="cd ~/dev/work/levelup/mentees/"
alias sb="cd ~/dev/personal/second_brain/"

# General aliases
alias k="kubectl"
alias s="kitty +kitten ssh"
alias nv="$EDITOR"
alias dev="tmuxp load dev"
alias eiv="$EDITOR ~/.config/nvim/init.vim"
alias erc="$EDITOR ~/.zshrc"
alias sz="source ~/.zshrc"
alias lt="tree -aI '.git'"
alias tks="tmux kill-server"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

ALIAS_FILE="$HOME/.aliases"
if [ -e "$ALIAS_FILE" ]
then
    . "$ALIAS_FILE"
fi

# NOTE: might add this back in later.
#sysinfo () {
#    # Display system info from motd scripts when the shell starts up
#    for i in /etc/update-motd.d/*
#    do
#        if [ "$i" != "/etc/update-motd.d/98-fsck-at-reboot" ]
#        then
#            $i
#        fi
#    done
#}
#sysinfo

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
