export PS1="\[\033[33;1m\]\w\[\033[m\] ❯❯❯ "

source ~/.dotjitsu/etc/fzf.bash

. "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"

# fnm (Fast Node Manager)
eval "$(fnm env)"      # Colourify common commands (unalias things that breaks)

alias eza='eza --group-directories-first'
alias ls='gls --color --group-directories-first'
alias l='eza -Ga'        # Lists in multi column, hidden files.
alias ll='eza -lah'      # Lists in one column, hidden files.
alias lr='ll -R'         # Lists human readable sizes, recursively.
alias la='ll -A'         # Lists human readable sizes, hidden files.
. "$HOME/.cargo/env"
