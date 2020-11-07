#!/usr/bin/env zsh

ulimit -n 10000
# zmodload zsh/zprof

# ----------------------------------------------------------------------------
# Zplug
# ----------------------------------------------------------------------------
# install zplug if required
export ZPLUG_HOME=$HOME/.repos/zplug
! [[ -d $HOME/.repos/zplug ]] && curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh

# zmodload zsh/zprof

source $ZPLUG_HOME/init.zsh

#zplug "modules/prompt", from:prezto



zplug "sorin-ionescu/prezto"
zplug "eth-p/bat-extras"
zplug "unixorn/git-extra-commands"
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "junegunn/fzf", use:"shell/*.zsh", defer:1

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
# if ! zplug check; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi


source "${ZDOTDIR:-$HOME}/.env"
source ~/.private/.zshrc
source "/usr/local/etc/grc.zsh"      # Colourify common commands (unalias things that breaks)

# fnm (Fast Node Manager)
eval "$(fnm env)"      # Colourify common commands (unalias things that breaks)



# ----------------------------------------------------
# Tmux
# ----------------------------------------------------
# if which tmux 2>&1 >/dev/null; then
#   if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
#     # echo "Loading tmux..."
#     #tmux attach -t hack || tmux new -s hack; exit
#   else
#     neofetch
#   fi
# fi


# Colors
eval $(gdircolors -b $DOTJITSU/packages/dircolors/dircolors.ansi-dark)

# Automatically list directory contents on `cd`.
auto-cd () {
  emulate -L zsh;
  # explicit sexy ls'ing as aliases arent honored in here.
  #hash gls >/dev/null 2>&1 && CLICOLOR_FORCE=1 gls -AFh --color --group-directories-first || ls -A
  exa -a --group-directories-first
  [ -f "package.json" ] && cs package.json
  [ -d ".git" ] && git recent

  local dirs=`find . -maxdepth 1 -mindepth 1 -type d | wc -l`
  local files=`find . -maxdepth 1 -mindepth 1 -type f | wc -l`
  local total=`find . -maxdepth 1 -mindepth 1 | wc -l`
  #echo -e "$total items ($dirs dirs| $files files)"

  #local total=`memoize fd . $PWD | wc -l`
  echo -e "\n$dirs directories, $files files, $total total"
  #echo -e "`files.last_modified_directory`"

}

chpwd_functions=( auto-cd $chpwd_functions )



# Load zplug
zplug load --verbose
# zplug load

source "$HOME/.aliases"
