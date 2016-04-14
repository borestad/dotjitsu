if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

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
  docker
  htop
  fasd
  # z
)


for file in $files; do
  source "${DOTJITSU}/packages/${file}/${file}.zsh"
done


if [[ `uname` == 'Linux' ]] then export LINUX=1; else export LINUX=; fi
if [[ `uname` == 'Darwin' ]] then export OSX=1; else export OSX=; fi

export HISTFILE=~/.zsh_history
export EDITOR='atom'
export VISUAL='atom'
export PAGER='less'


# Read aliases
source "$HOME/.aliases"

# Access private configuration
if [[ -a ~/.private/.zshrc ]]
then
  source ~/.private/.zshrc
fi

# Prezto seems to override grc with some annoying alias
unalias grc
unalias gcp
unalias gls

# fpath=(/usr/local/share/zsh-completions $fpath)

# eval "$(rbenv init --no-rehash -)"
# (rbenv rehash &) 2> /dev/null

# GRC colorizes nifty unix tools all over the place
source "`brew --prefix`/etc/grc.bashrc"

# bind hh to Ctrl-r (for Vi mode check doc)
bindkey -s "\C-r" "\eqhh\n"

# Autojump
#[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# Lunchy
LUNCHY_DIR=$(dirname `gem which lunchy`)/../extras
if [ -f $LUNCHY_DIR/lunchy-completion.zsh ]; then
  . $LUNCHY_DIR/lunchy-completion.zsh
fi

# Fuck
eval $(thefuck --alias)

# Go to default directory
# chdir.default

# Enable syntax highlighting
#source "`brew --prefix`/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
