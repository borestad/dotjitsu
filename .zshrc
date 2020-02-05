#!/usr/bin/env zsh
# zmodload zsh/zprof

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

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


#eval "$(fasd --init auto)"              # Fasd autocompletion,shortcuts etc ($ z ...)
# eval "$(fasd --init posix-alias zsh-hook)"
source "${ZDOTDIR:-$HOME}/.env"
source "$DOTJITSU/.docker-aliases"
source ~/.private/.zshrc
source $DOTJITSU/.fzf                   # (CTRL-R on steroids)
source "/usr/local/etc/grc.bashrc"      # Colourify common commands (unalias things that breaks)
source "$HOME/.aliases"

# Colors
#eval $(gdircolors -b $DOTJITSU/packages/dircolors/dircolors.ansi-dark)

# Automatically list directory contents on `cd`.
auto-cd () {
  emulate -L zsh;
  # echo "Last modified: `files.last_modified_directory`"
  # explicit sexy ls'ing as aliases arent honored in here.
  hash gls >/dev/null 2>&1 && CLICOLOR_FORCE=1 gls -AFh --color --group-directories-first || ls -A
  # local dirs=`find . -maxdepth 1 -mindepth 1 -type d | wc -l`
  # local files=`find . -maxdepth 1 -mindepth 1 -type f | wc -l`
  # local total=`find . -maxdepth 1 -mindepth 1| wc -l`

  # echo -e "total $total ($dirs | $files)"

  [ -f "package.json" ] && cs package.json

}

chpwd_functions=( auto-cd $chpwd_functions )
