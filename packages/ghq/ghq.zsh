alias ghc='cd $(ghq list --full-path | fzf)'
alias ghf='find $(git rev-parse --show-cdup) -type f | grep -v "/.git/" | fzf'
alias gho='(cd $(ghq list --full-path | fzf) && git browse)'
