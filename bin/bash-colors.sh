#!/usr/bin/env bash
# https://github.com/ppo/bash-colors (v0.3.0)


#  ┌───────┬────────────────┬─────────────────┐   ┌───────┬─────────────────┬───────┐
#  │ Fg/Bg │ Color          │ Octal           │   │ Code  │ Style           │ Octal │
#  ├───────┼────────────────┼─────────────────┤   ├───────┼─────────────────┼───────┤
#  │  K/k  │ Black          │ \e[ + 3/4  + 0m │   │  s/S  │ Bold (strong)   │ \e[1m │
#  │  R/r  │ Red            │ \e[ + 3/4  + 1m │   │  d/D  │ Dim             │ \e[2m │
#  │  G/g  │ Green          │ \e[ + 3/4  + 2m │   │  i/I  │ Italic          │ \e[3m │
#  │  Y/y  │ Yellow         │ \e[ + 3/4  + 3m │   │  u/U  │ Underline       │ \e[4m │
#  │  B/b  │ Blue           │ \e[ + 3/4  + 4m │   │  f/F  │ Blink (flash)   │ \e[5m │
#  │  M/m  │ Magenta        │ \e[ + 3/4  + 5m │   │  n/N  │ Negative        │ \e[7m │
#  │  C/c  │ Cyan           │ \e[ + 3/4  + 6m │   │  h/H  │ Hidden          │ \e[8m │
#  │  W/w  │ White          │ \e[ + 3/4  + 7m │   │  t/T  │ Strikethrough   │ \e[9m │
#  ├───────┴────────────────┴─────────────────┤   ├───────┼─────────────────┼───────┤
#  │  High intensity        │ \e[ + 9/10 + *m │   │   0   │ Reset           │ \e[0m │
#  └────────────────────────┴─────────────────┘   └───────┴─────────────────┴───────┘
#                                                  Uppercase = Reset a style: \e[2*m


pf() { printf "$@"; }
c() { [ $# == 0 ] && pf "\e[0m" || pf "$1" | sed 's/\(.\)/\1;/g;s/\([SDIUFNHT]\)/2\1/g;s/\([KRGYBMCW]\)/3\1/g;s/\([krgybmcw]\)/4\1/g;y/SDIUFNHTsdiufnhtKRGYBMCWkrgybmcw/12345789123457890123456701234567/;s/^\(.*\);$/\\e[\1m/g'; }
cecho() { [ $# == 1 ] && echo -e "$1" || echo -e "$(c $1)${2}$(c)"; }

cechon() { echo -en "$(c $1)${2}$(c)"; }
cprintf() { [ $# == 1 ] && pf "$1" || pf "$(c $1)${2}$(c)"; }

log.ok() { cechon Kg " OK "; pf " "; }
log.error() { cechon Wr " Error "; pf " "; }
