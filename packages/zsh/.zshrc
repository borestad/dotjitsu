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
  z
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

# Select framework
source "${DOTJITSU}/packages/$DOTJUTSU_FRAMEWORK/.$DOTJUTSU_FRAMEWORK"

# Read aliases
source "$HOME/.aliases"

# Access private configuration
if [[ -a ~/.private/zshrc ]]
then
  source ~/.private/zshrc
fi

eval "$(rbenv init --no-rehash -)"
(rbenv rehash &) 2> /dev/null

# GRC colorizes nifty unix tools all over the place
source "`brew --prefix`/etc/grc.bashrc"
bindkey -s "\C-r" "\eqhh\n"     # bind hh to Ctrl-r (for Vi mode check doc)

# Go to default directory
# chdir.default

# Enable syntax highlighting
source "`brew --prefix`/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
