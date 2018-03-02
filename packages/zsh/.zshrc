#!/usr/bin/env zsh

ulimit -n 20000

source "${ZDOTDIR:-$HOME}/.env"

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

eval $(gdircolors -b $DOTJITSU/packages/dircolors/dircolors.ansi-dark)

# Read aliases
source "$HOME/.aliases"

# Access private configuration
[[ -a ~/.private/.zshrc ]] && source ~/.private/.zshrc

# Prezto seems to override grc with some annoying alias
unalias grc 2> /dev/null
unalias gcp 2> /dev/null
unalias gls 2> /dev/null

#source /usr/local/share/chruby/chruby.sh
#source /usr/local/share/chruby/auto.sh

# GRC colorizes nifty unix tools all over the place
source "/usr/local/etc/grc.bashrc"

# Fuck
# eval $(thefuck --alias)
alias fuck='TF_CMD=$(TF_ALIAS=fuck PYTHONIOENCODING=utf-8 TF_SHELL_ALIASES=$(alias) thefuck $(fc -ln -1 | tail -n 1)) && eval $TF_CMD && print -s $TF_CMD'

# Automatically list directory contents on `cd`.
auto-ls () {
  emulate -L zsh;
  # explicit sexy ls'ing as aliases arent honored in here.
  hash gls >/dev/null 2>&1 && CLICOLOR_FORCE=1 gls -aFh --color --group-directories-first || ls
}



unsetopt correct          # Disable ZSH annoying auto correct
unsetopt nomatch          # Disable ZSH annoying glob error
setopt APPEND_HISTORY     # Adds history
setopt INC_APPEND_HISTORY
setopt NO_BG_NICE         # Don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS      # Allow functions to have local options
setopt LOCAL_TRAPS        # Allow functions to have local traps
setopt HIST_VERIFY
setopt SHARE_HISTORY      # Share history between sessions ???
setopt EXTENDED_HISTORY   # Add timestamps to history
setopt PROMPT_SUBST
#setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF
setopt HIST_IGNORE_ALL_DUPS  # Don't record dupes in history
setopt HIST_REDUCE_BLANKS


source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.repos/git-subrepo/.rc
source $HOME/.repos/zsh-better-npm-completion/zsh-better-npm-completion.plugin.zsh

auto-pkg-scripts () {
  emulate -L zsh;
  [ -f "package.json" ] && cs package.json
}

chpwd_functions=( auto-ls auto-pkg-scripts $chpwd_functions )


source ~/.fzf

# Automatically load .envrc files
# https://github.com/direnv/direnv
eval "$(direnv hook zsh)"

files=(
  # options
  # path
  # terminfo
  # completion
  # colors
  # vim
  # prompt
  # plugins
  # locale
  # exports
  # aliases
  # functions
  # fzf
  # history
  # bindkeys
  # terminal
  # autopair
  aka
  #iterm2
  htop
  #fasd
  docker
  # z
)

#source "${DOTJITSU}/packages/iterm2/_iterm2.zsh"

# Fasd autocompletion
eval "$(fasd --init auto)"

source "${DOTJITSU}/packages/docker/docker.zsh"

#source ~/.repos/k/k.sh
#source ~/.repos/zaw/zaw.zsh

# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#   . $(brew --prefix)/etc/bash_completion
# fi


# tabtab source for yarn package
# uninstall by removing these lines or running `tabtab uninstall yarn`
[[ -f /Users/johan.borestad/.config/yarn/global/node_modules/yarn-completions/node_modules/tabtab/.completions/yarn.zsh ]] && . /Users/johan.borestad/.config/yarn/global/node_modules/yarn-completions/node_modules/tabtab/.completions/yarn.zsh


# NVM 
# =================================================================
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# place this after nvm initialization!
autoload -U add-zsh-hook

load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc





# Better history
# Credits to https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
# autoload -U up-line-or-beginning-search
# autoload -U down-line-or-beginning-search
# zle -N up-line-or-beginning-search
# zle -N down-line-or-beginning-search
# bindkey "^[[A" up-line-or-beginning-search # Up
# bindkey "^[[B" down-line-or-beginning-search # Down


# autoload -Uz compinit && compinit -i