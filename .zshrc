#!/usr/bin/env zsh

ulimit -n 10000

if [[ $TERM_PROGRAM == "iTerm.app" ]]; then
  echo -ne "\033]0;$(pwd | sed -e "s#/Users/$(whoami)#~#" -e 's#~/git/##')\007"
fi

# ===================================================
# ⚡️ Plumbing
# ===================================================
# Bootstrap settings
export ZSH_EVALCACHE_DIR=$HOME/.cache/zsh-evalcache

# Fix for homebrew on M1 macs
if [[ -f /opt/homebrew/bin/brew ]]; then
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
    export HOMEBREW_PREFIX="/opt/homebrew"
else
    export HOMEBREW_PREFIX="/usr/local"
fi

# If not running interactively, don't do anything
[[ -o interactive ]] || return

# ===================================================
# ⚡️ Profiling Tools
# ===================================================
PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
    zmodload zsh/zprof
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    PS4=$'%D{%M%S%.} %N:%i> '
    exec 3>&2 2>$HOME/startlog.$$
    setopt xtrace prompt_subst
fi

# ===================================================
# ⚡️ Prompt
# ===================================================
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


source ~/.private/.zshrc

# ===================================================
# ⚡️ Plugins
# ===================================================

# ■■■ Zinit initialization
declare -A ZINIT
ZINIT[ZCOMPDUMP_PATH]=~/.cache/zcompdump-zinit
ZINIT[HOME_DIR]=~/.cache/zinit
source ~/.repos/zinit/bin/zinit.zsh

# ■■■ Zinit Plugins
zinit light NICHOLAS85/z-a-eval
zinit light zdharma-continuum/zinit-annex-submods
zinit light mroth/evalcache

# ■■■ Prezto modules - configured via ~/.zprestorc
source ~/.dotjitsu/.zpreztorc

# https://github.com/zdharma/zinit/issues/421
zinit snippet PZT::modules/environment/init.zsh
# zinit ice svn wait as=null lucid; zinit snippet PZTM::utility
# zinit ice svn wait as=null lucid; zinit snippet PZTM::archive
zinit snippet PZT::modules/terminal/init.zsh
zinit snippet PZT::modules/editor/init.zsh
zinit snippet PZT::modules/history/init.zsh
zinit snippet PZT::modules/directory/init.zsh
# zinit ice svn wait as=null lucid; zinit snippet PZTM::osx
zinit snippet PZT::modules/rsync/init.zsh
zinit snippet PZT::modules/completion/init.zsh # Loaded last

# ■■■
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# ■■■ Powerlevel10k Prompt
zinit ice depth=1
zinit light romkatv/powerlevel10k

# ■■■ fzf (autocomplete, keybindings)
# . ~/.dotjitsu/etc/fzf.zsh
# zinit ice wait lucid
zinit snippet /opt/homebrew/opt/fzf/shell/completion.zsh
zinit snippet /opt/homebrew/opt/fzf/shell/key-bindings.zsh

# ■■■ History substring searching
bindkey -r '^[[A'; bindkey -r '^[[B'
function __bind_history_keys() {
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
}
zinit ice wait"0b" lucid atload'__bind_history_keys'
zinit load zsh-users/zsh-history-substring-search

# ■■■ cd with fzf - https://git.io/vbHlm
# zinit ice wait lucid
# zinit light changyuheng/zsh-interactive-cd

# ■■■ cd (and more) with fzf: https://github.com/Aloxaf/fzf-tab
zinit light Aloxaf/fzf-tab
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'dir-info ${realpath//\\ / }; echo; eza --colour=always --group-directories-first --icons -la --no-permissions --no-user -L1 --no-time --icons --git-ignore -I "*.git" "${realpath//\\ / }"'
zstyle ':fzf-tab:*' switch-group ',' '.'

# zinit ice wait lucid
# zinit load marlonrichert/zsh-autocomplete


# ■■■ git-extras - https://git.io/JztIv
zinit ice wait lucid
zinit light unixorn/git-extra-commands

# ■■■ Snippets
zinit snippet ~/.dotjitsu/.env$
zinit snippet ~/.dotjitsu/.hooks
zinit snippet ~/.dotjitsu/.aliases
zinit snippet ~/.dotjitsu/.keybindings
zinit snippet ~/.dotjitsu/packages/iterm2/.iterm2_shell_integration.zsh
# zinit snippet ~/.dotjitsu/packages/iterm2/_iterm2.zsh
zinit snippet "/opt/homebrew/etc/grc.zsh"
zinit snippet "$HOMEBREW_PREFIX/opt/git-extras/share/git-extras/git-extras-completion.zsh"
# zinit snippet ~/.docker-aliases$

# ■■■ Evals
eval $(gdircolors -b $DOTJITSU/packages/dircolors/ansi-light.dircolors)
unalias zi
eval "$(thefuck --alias)"
eval "$(zoxide init zsh)"
eval "$(fnm env --use-on-cd --version-file-strategy recursive)"

#_evalcache direnv hook  zsh


# ===================================================
# ⚡️ ZSH options
# ===================================================
set +o list_types               # Disable forward slashes
# ■■■ Basics
setopt NO_BEEP                  # don't beep on error
setopt NO_HIST_BEEP             # don't beep on no history
setopt NO_LIST_BEEP             # don't beep on no list
set bell-style none

# ■■■ Changing Directories
setopt AUTO_CD                  # If you type foo, and it isn't a command, and it is a directory in your cdpath, go there
setopt CDABLEVARS               # if argument to cd is the name of a parameter whose value is a valid directory, it will become the current directory
setopt PUSHD_IGNORE_DUPS        # Don't push multiple copies of the same directory onto the directory stack

# ■■■ Prompt
setopt PROMPT_SUBST             # enable parameter expansion, command substitution, and arithmetic expansion in the prompt
setopt TRANSIENT_RPROMPT        # only show the rprompt on the current prompt

# ■■■ Unset
unsetopt CORRECT                # Disable ZSH annoying auto correct
unsetopt NOMATCH                # Disable ZSH annoying glob error
unsetopt EXTENDED_HISTORY       # Record timestamp of command in HISTFILE

# ■■■ History
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

# ■■■ Scripts etc
setopt dotglob                  # Allow dotfiles in globs
typeset -U path                 # ignore doules in path


#zinit snippet ~/.p10k.zsh
source ~/.p10k.zsh


fpath=(
  $HOMEBREW_PREFIX/share/zsh/site-functions
  $HOME/.local/share/zsh/site-functions
  $fpath
)

# ===================================================
# ⚡️ LOAD
# ===================================================
zicompinit
zinit cdreplay

# eval "$(bkt -- atuin init zsh --disable-up-arrow)"
# eval "$(atuin init zsh)"

# disable-fzf-tab
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.


# Run dotenv on login
#dotenv

# Wasmer
export WASMER_DIR="$HOME/.config/wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

export GPG_TTY=$(tty)
tere() {
    local result=$(command tere "$@")
    [ -n "$result" ] && cd -- "$result"
}
