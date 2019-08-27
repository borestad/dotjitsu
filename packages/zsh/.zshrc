#!/usr/bin/env zsh

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

# Fasd autocompletion,shortcuts etc ($ z ...)
eval "$(fasd --init auto)"

source "${ZDOTDIR:-$HOME}/.env"
source "$HOME/.aliases"
source "$DOTJITSU/packages/docker/.docker-aliases"
source ~/.private/.zshrc

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
export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh" # This loads nvm

# place this after nvm initialization!
#autoload -U add-zsh-hook

load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install --lts
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

#add-zsh-hook chpwd load-nvmrc


ln -sf `which node` $HOME/bin/node
ln -sf $HOME/bin/node /usr/local/bin/node


#[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

fpath=(/usr/local/share/zsh-completions $fpath)

# (CTRL-R on steroids)
source $DOTJITSU/packages/fzf/.fzf

# Colourify common commands (unalias things that breaks)
source "/usr/local/etc/grc.bashrc"
unalias docker

autoload -Uz compinit && compinit -i
