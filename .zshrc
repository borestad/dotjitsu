if [[ `uname` == 'Linux' ]] then export LINUX=1; else export LINUX=; fi
if [[ `uname` == 'Darwin' ]] then export OSX=1; else export OSX=; fi

export HISTFILE=~/.zsh_history
export EDITOR='atom'
export VISUAL='atom'
export PAGER='less'


# Select framework
source "${DOTJITSU}/lib/zsh/$DOTJUTSU_FRAMEWORK/zshrc"

# Read aliases
source "${DOTJITSU}/.aliases"

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
