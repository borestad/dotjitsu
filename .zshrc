DOTJITSU=$HOME/.dotjitsu
DOTJUTSU_FRAMEWORK="oh-my-zsh"

if [[ `uname` == 'Linux' ]] then export LINUX=1; else export LINUX=; fi
if [[ `uname` == 'Darwin' ]] then export OSX=1; else export OSX=; fi

# Select framework
source "${DOTJITSU}/zsh/$DOTJUTSU_FRAMEWORK/zshrc"

# Access private configuration
if [[ -a ~/.private/zshrc ]]
then
  source ~/.private/zshrc
fi

export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"
eval "$(rbenv init --no-rehash -)"
(rbenv rehash &) 2> /dev/null


# Customize to your needs...

# Prezto seems to override grc with some annoying alias
#unalias grc
#unalias gcp
#unalias gls

#source "${ZDOTDIR:-$HOME}/.dotfiles/packages/zsh/osx.zsh"

#test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

# source "${HOME}/.zgen/zgen.zsh"

# if ! zgen saved; then
#   # load oh my zsh
#   zgen oh-my-zsh
#   zgen save
#  fi

# source $DOTJITSU/antigen.zsh
#
# # Use oh-my-zsh as a base
# antigen use oh-my-zsh
#
# antigen bundle git
# antigen bundle heroku
# antigen bundle pip
# antigen bundle command-not-found
#
# antigen bundle zsh-users/zsh-syntax-highlighting
# antigen bundle kennethreitz/autoenv
# antigen bundle Tarrasch/zsh-autoenv
# antigen bundle zsh-users/zsh-history-substring-search
#
# # Antigen: we're done!
# antigen apply
