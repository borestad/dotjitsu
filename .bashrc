export PS1="\[\033[33;1m\]\w\[\033[m\] ❯❯❯ "

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

. "/usr/local/etc/profile.d/bash_completion.sh"


# fnm (Fast Node Manager)
eval "$(fnm env)"      # Colourify common commands (unalias things that breaks)
