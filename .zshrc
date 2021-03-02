#!/usr/bin/env zsh

ulimit -n 10000
# zmodload zsh/zprof

#source "$HOME/.env"

unsetopt correct              # Disable ZSH annoying auto correct
unsetopt nomatch              # Disable ZSH annoying glob error

setopt APPEND_HISTORY         # Adds history
setopt COMPLETE_IN_WORD
setopt EXTENDED_HISTORY       # Record timestamp of command in HISTFILE
setopt HIST_IGNORE_ALL_DUPS   # Don't record dupes in history
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt IGNORE_EOF
setopt INC_APPEND_HISTORY
setopt LOCAL_TRAPS            # Allow functions to have local traps
setopt NO_HUP
setopt NO_LIST_BEEP
setopt PROMPT_SUBST
setopt SHARE_HISTORY          # Share history between sessions ???

#setopt NO_BG_NICE         # Don't nice background tasks
# setopt LOCAL_OPTIONS     # Allow functions to have local options (breaks directory plugin)

# ----------------------------------------------------------------------------
# Zplug
# ----------------------------------------------------------------------------
# install zplug if required
export ZPLUG_HOME=$HOME/.repos/zplug
! [[ -d $HOME/.repos/zplug ]] && curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh

# zmodload zsh/zprof

source $ZPLUG_HOME/init.zsh

zplug "sorin-ionescu/prezto"
zplug "eth-p/bat-extras"
zplug "unixorn/git-extra-commands"
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
# zplug "wookayin/fzf-fasd"
zplug "junegunn/fzf", use:"shell/*.zsh", defer:1

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
# if ! zplug check; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi


source "${ZDOTDIR:-$HOME}/.env"
source $HOME/.private/.zshrc
source "/usr/local/etc/grc.zsh"       # Colourify common commands (unalias things that breaks)
eval "$(fnm env)"                     # fnm (Fast Node Manager)
eval $(gdircolors -b $DOTJITSU/packages/dircolors/dircolors.ansi-dark)

# ----------------------------------------------------
# Tmux
# ----------------------------------------------------
# if which tmux 2>&1 >/dev/null; then
#   if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
#     # echo "Loading tmux..."
#     #tmux attach -t hack || tmux new -s hack; exit
#   else
#     neofetch
#   fi
# fi


# Colors






# Load zplug
zplug load #--verbose
# zplug load

source "$HOME/.aliases"
source "${HOME}/.docker-aliases"
source $DOTJITSU/~keybindings
source $DOTJITSU/~hooks
