#!/usr/bin/env zsh
# zmodload zsh/zprof

ulimit -n 10000

# ----------------------------------------------------
# Init Prezto
# ----------------------------------------------------
source "$HOME/.repos/zprezto/init.zsh"

# ----------------------------------------------------
# Tmux
# ----------------------------------------------------
if which tmux 2>&1 >/dev/null; then
  if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
    # echo "Loading tmux..."
    #tmux attach -t hack || tmux new -s hack; exit
  else
    neofetch
  fi
fi


eval "$(fasd --init auto)"              # Fasd autocompletion,shortcuts etc ($ z ...)
source "${ZDOTDIR:-$HOME}/.env"
source "$DOTJITSU/.docker-aliases"
source ~/.private/.zshrc
source $DOTJITSU/.fzf                   # (CTRL-R on steroids)
source "/usr/local/etc/grc.bashrc"      # Colourify common commands (unalias things that breaks)
source "$HOME/.aliases"

# Colors
eval $(gdircolors -b $DOTJITSU/packages/dircolors/dircolors.ansi-dark)

# Automatically list directory contents on `cd`.
auto-ls () {
  emulate -L zsh;
  # explicit sexy ls'ing as aliases arent honored in here.
  hash gls >/dev/null 2>&1 && CLICOLOR_FORCE=1 gls -aFh --color --group-directories-first || ls
}

auto-pkg-scripts () {
  emulate -L zsh;
  [ -f "package.json" ] && cs package.json
}

chpwd_functions=( auto-ls auto-pkg-scripts $chpwd_functions )

# Automatically load .envrc files
# https://github.com/direnv/direnv
#eval "$(direnv hook zsh)"


# export JAVA_HOME="$(/usr/libexec/java_home -v 10)"


# NVM
# =================================================================
# wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
# export NVM_DIR="$HOME/.nvm"
# declare -a NODE_GLOBALS=(`find ~/.nvm/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)
# NODE_GLOBALS+=("node")
# NODE_GLOBALS+=("nvm")

# load_nvm () {
#     export NVM_DIR=~/.nvm
#     [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
# }

# for cmd in "${NODE_GLOBALS[@]}"; do
#     eval "${cmd}(){ unset -f ${NODE_GLOBALS}; load_nvm; ${cmd} \$@ }"
# done

# # place this after nvm initialization!
# #autoload -U add-zsh-hook

# load-nvmrc() {
#   local node_version="$(nvm version)"
#   local nvmrc_path="$(nvm_find_nvmrc)"

#   if [ -n "$nvmrc_path" ]; then
#     local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

#     if [ "$nvmrc_node_version" = "N/A" ]; then
#       nvm install --lts
#     elif [ "$nvmrc_node_version" != "$node_version" ]; then
#       nvm use
#     fi
#   elif [ "$node_version" != "$(nvm version default)" ]; then
#     echo "Reverting to nvm default version"
#     nvm use default
#   fi
# }

#add-zsh-hook chpwd load-nvmrc

# NVM_DEFAULT=`cat $HOME/.nvm/alias/default`
#NODE_DEFAULT_PATH="$HOME/.nvm/versions/node/v$NVM_DEFAULT/bin/node"
#ln -sf $NODE_DEFAULT_PATH $HOME/bin/node
#ln -sf $NODE_DEFAULT_PATH /usr/local/bin/node
fpath=(/usr/local/share/zsh-completions $fpath)


#autoload -Uz compinit && compinit -i
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# zprof
