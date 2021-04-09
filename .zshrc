#!/usr/bin/env zsh

ulimit -n 10000
source ~/.private/.zshrc

# zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ----------------------------------------------------------------------------
# Zplug
# ----------------------------------------------------------------------------
# install zplug if required
export ZPLUG_HOME=$HOME/.repos/zplug
source $ZPLUG_HOME/init.zsh

zplug "sorin-ionescu/prezto"
zplug "eth-p/bat-extras"
zplug "unixorn/git-extra-commands"
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
# zplug "wookayin/fzf-fasd"
zplug "junegunn/fzf", use:"shell/*.zsh", defer:1

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi


source /usr/local/etc/grc.zsh       # Colourify common commands (unalias things that breaks)
source ~/.repos/powerlevel10k/config/p10k-robbyrussell.zsh
source ~/.repos/powerlevel10k/powerlevel10k.zsh-theme # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source ${ZDOTDIR:-$HOME}/.env
source $DOTJITSU/~hooks
source $DOTJITSU/~keybindings

eval "$(fnm env)"                     # fnm (Fast Node Manager)
eval $(gdircolors -b $DOTJITSU/packages/dircolors/dircolors.ansi-dark)
eval "$(fasd --init auto)"


# ===== Load Zplug
zplug load #--verbose

source ~/.aliases
source ~/.docker-aliases

# ===== Basics
setopt NO_BEEP                  # don't beep on error
setopt NO_HIST_BEEP             # don't beep on no history
setopt NO_LIST_BEEP             # don't beep on no list

# ===== Changing Directories
setopt AUTO_CD                  # If you type foo, and it isn't a command, and it is a directory in your cdpath, go there
setopt CDABLEVARS               # if argument to cd is the name of a parameter whose value is a valid directory, it will become the current directory
setopt PUSHD_IGNORE_DUPS        # Don't push multiple copies of the same directory onto the directory stack

# ===== Prompt
setopt PROMPT_SUBST             # enable parameter expansion, command substitution, and arithmetic expansion in the prompt
setopt TRANSIENT_RPROMPT        # only show the rprompt on the current prompt

unsetopt CORRECT                # Disable ZSH annoying auto correct
unsetopt NOMATCH                # Disable ZSH annoying glob error
unsetopt EXTENDED_HISTORY       # Record timestamp of command in HISTFILE

setopt APPEND_HISTORY           # Adds history
setopt COMPLETE_IN_WORD         # If unset, the cursor is set to the end of the word if completion is started. Otherwise it stays there and completion is done from both ends.
setopt HIST_IGNORE_ALL_DUPS     # Don't record dupes in history
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks from each command line being added to the history list.
setopt HIST_VERIFY
setopt IGNORE_EOF
setopt INC_APPEND_HISTORY
setopt LOCAL_TRAPS              # Allow functions to have local traps
setopt MENU_COMPLETE            # On an ambiguous completion, insert the first match immediately
setopt NO_HUP
setopt SHARE_HISTORY            # Share history between sessions ???



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
