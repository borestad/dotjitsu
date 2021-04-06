export PS1="\[\033[33;1m\]\w\[\033[m\] ❯❯❯ "

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

. "/usr/local/etc/profile.d/bash_completion.sh"

# fnm (Fast Node Manager)
eval "$(fnm env)"      # Colourify common commands (unalias things that breaks)

alias exa='exa --group-directories-first'
alias ls='gls --color --group-directories-first'
alias l='exa -Ga'        # Lists in multi column, hidden files.
alias ll='exa -lah'      # Lists in one column, hidden files.
alias lr='ll -R'         # Lists human readable sizes, recursively.
alias la='ll -A'         # Lists human readable sizes, hidden files.
