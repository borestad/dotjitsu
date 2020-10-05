export PS1="\[\033[33;1m\]\w\[\033[m\] ❯❯❯ "

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

. "/usr/local/etc/profile.d/bash_completion.sh"


source $HOME/.config/broot/launcher/bash/br

# fnm (Fast Node Manager)
eval "$(fnm env --multi)"      # Colourify common commands (unalias things that breaks)
