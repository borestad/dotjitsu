#!/usr/bin/env zsh

ulimit -n 10000

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
zinit light zinit-zsh/z-a-submods
zinit light mroth/evalcache

# ■■■ Prezto modules - configured via ~/.zprestorc

source ~/.dotjitsu/.zpreztorc

zinit snippet PZT::modules/environment/init.zsh
zinit snippet PZT::modules/utility/init.zsh
zinit snippet PZT::modules/terminal/init.zsh
zinit snippet PZT::modules/editor/init.zsh
zinit snippet PZT::modules/history/init.zsh
zinit snippet PZT::modules/fasd/init.zsh
zinit snippet PZT::modules/directory/init.zsh
zinit snippet PZT::modules/completion/init.zsh
zinit snippet PZT::modules/osx/init.zsh
zinit snippet PZT::modules/rsync/init.zsh

# ■■■
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# ■■■ Powerlevel10k Prompt
zinit ice depth=1
zinit light romkatv/powerlevel10k

# ■■■ fzf (autocomplete, keybindings)
zinit ice wait lucid
zinit snippet ~/.dotjitsu/fzf.zsh

# ■■■ fasd (z) with fzf
zinit snippet ~/.dotjitsu/packages/zsh/fzf-fasd.plugin.zsh

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
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'dir-info ${realpath//\\ / }; echo; exa --group-directories-first --icons -la --no-permissions --no-user -L1 --no-time --icons --git-ignore -I "*.git" "${realpath//\\ / }"'
zstyle ':fzf-tab:*' switch-group ',' '.'

# zinit ice wait lucid
# zinit load marlonrichert/zsh-autocomplete


# ■■■ git-extras - https://git.io/JztIv
zinit ice wait lucid
zinit light unixorn/git-extra-commands

zinit ice wait lucid
zinit snippet /usr/local/opt/git-extras/share/git-extras/git-extras-completion.zsh

# ■■■ Snippets
zinit snippet ~/.dotjitsu/.env$
zinit snippet ~/.dotjitsu/.hooks$
zinit snippet ~/.dotjitsu/.aliases$
zinit snippet ~/.dotjitsu/.keybindings$
zinit snippet ~/.dotjitsu/packages/iterm2/.iterm2_shell_integration.zsh
# zinit snippet ~/.docker-aliases$


# ■■■ Evals
eval "$(fnm env)"                     # fnm (Fast Node Manager)
eval $(gdircolors -b $DOTJITSU/packages/dircolors/ansi-light.dircolors)
_evalcache thefuck --alias


# ===================================================
# ⚡️ ZSH options
# ===================================================
set +o list_types               # Disable forward slashes
# ■■■ Basics
setopt NO_BEEP                  # don't beep on error
setopt NO_HIST_BEEP             # don't beep on no history
setopt NO_LIST_BEEP             # don't beep on no list

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


zinit snippet ~/.p10k.zsh

# ===================================================
# ⚡️ LOAD
# ===================================================
zicompinit
zinit cdreplay

# disable-fzf-tab
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.



eval $(thefuck --alias)
