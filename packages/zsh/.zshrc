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

# eval "$(rbenv init --no-rehash -)"
# (rbenv rehash &) 2> /dev/null

# GRC colorizes nifty unix tools all over the place
source "`brew --prefix`/etc/grc.bashrc"

# bind hh to Ctrl-r (for Vi mode check doc)
# bindkey -s "\C-r" "\eqhh\n"

# Autojump
#[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# Lunchy
LUNCHY_DIR=$(dirname `gem which lunchy`)/../extras
if [ -f $LUNCHY_DIR/lunchy-completion.zsh ]; then
  . $LUNCHY_DIR/lunchy-completion.zsh
fi

# Fuck
eval $(thefuck --alias)

# Automatically list directory contents on `cd`.
auto-ls () {
  emulate -L zsh;
  # explicit sexy ls'ing as aliases arent honored in here.
  hash gls >/dev/null 2>&1 && CLICOLOR_FORCE=1 gls -aFh --color --group-directories-first || ls
}


# Go to default directory
# chdir.default

# Enable syntax highlighting
#source "`brew --prefix`/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.repos/zsh-better-npm-completion/zsh-better-npm-completion.plugin.zsh
GIT_SUBREPO_ROOT="$HOME/.repos/git-subrepo"
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
  fasd
  docker
  # z
)


for file in $files; do
  source "${DOTJITSU}/packages/${file}/${file}.zsh"
done

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
  
autoload -Uz compinit && compinit -i
