export CDPATH=.:~

cdpaths="$([ -d ~/code ] && find ~/code -mindepth 1 -type d | egrep -v '/(\.)|_[a-zA-Z0-9]' | egrep -v 'bin|node_modules|cmd|doc|lib|pkg|test' | xargs -n1 dirname | uniq)"
for i in $cdpaths; do
  CDPATH=$CDPATH:$i
done
