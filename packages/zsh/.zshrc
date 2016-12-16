#!/usr/bin/env zsh

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

# fpath=(/usr/local/share/zsh-completions $fpath)
# fpath=(~/.zsh/completion $fpath)

source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

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


# Set correct ruby version
chruby ruby-2.3.3

# Disable ZSH annoying auto correct
unsetopt correct

# Enable syntax highlighting
# source "`brew --prefix`/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.repos/zsh-better-npm-completion/zsh-better-npm-completion.plugin.zsh
source $HOME/.repos/git-subrepo/.rc

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
  ghq
  iterm2
  htop
  #fasd
  docker
  # z
)

source "${DOTJITSU}/packages/ghq/ghq.zsh"
source "${DOTJITSU}/packages/iterm2/_iterm2.zsh"
source "${DOTJITSU}/packages/fasd/fasd.zsh"
source "${DOTJITSU}/packages/docker/docker.zsh"

# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#   . $(brew --prefix)/etc/bash_completion
# fi

autoload -Uz compinit && compinit -i

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
