#!/bin/zsh

# https://github.com/cpitt/zsh-dotenv

dotenv() {
  if [[ -f .env ]]; then
    if [[ -o a ]]; then
      source .env
    else
      set -a
      source .env
      set +a
    fi
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd source_env
