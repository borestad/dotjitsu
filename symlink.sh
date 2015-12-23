#!/bin/bash

cd "$(dirname "$0")"

ROOT=$(pwd -P)
DOTFILES="$ROOT/home"

mkdir -p $ROOT

if [[ -d "$ROOT" ]]; then
  echo ""
  echo "  === Symlinking dotfiles from $ROOT ==="
  echo ""
else
  echo "$ROOT does not exist"
  exit 1
fi

link() {
  from="$1"
  to="$2"
  echo "  ✓ '$from' => '$to'"
  rm -f "$to"
  ln -s "$from" "$to"
}

for location in $(find $DOTFILES -name '.*'); do
  file="${location##*/}"
  file="${file%.sh}"
  link "$location" "$HOME/$file"
done

echo ""
