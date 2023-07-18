#!/usr/bin/zsh
# vim: fdm=marker:fdc=1

# GNU and shell tools                                                       {{{1
alias ls='ls --color=always'
alias watch_cpu="watch -n 0 'lscpu | grep MHz'"
alias lsport="netstat -tulpn"
alias lssock="ss"
alias xrdb-replace='xrdb -remove -all && xrdb -load'
alias Clear="clear && print_greeting"
alias seecompose="$EDITOR /usr/share/X11/locale/en_US.UTF-8/Compose"
alias seekeys="xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'"
alias battery="upower -i /org/freedesktop/UPower/devices/battery_BAT0"

if which exa >/dev/null; then
  if which ll >/dev/null; then unalias ll; fi
  alias ll="exa -l -g --icons --color=always"
  alias lld="ll --group-directories-first | less"
  alias lt="ll -a -stime"
  alias lat="ll -a -stime"
  alias llt="ll -a -stime"
fi

if which fdfind >/dev/null; then
  alias fd="fdfind"
fi

if which batcat >/dev/null; then
  if ! which bat >/dev/null; then
    alias bat="batcat"
  fi
fi

if which ncdu >/dev/null; then
  alias du="ncdu --color dark"
fi

if which duf >/dev/null; then
  alias dufs="duf"
fi

# Required for kitty to ssh properly:
if [ "$TERM" = "xterm-kitty" ]; then
  alias ssh="kitty +kitten ssh"
fi
#                                                                           }}}1
# Editing config files                                                      {{{1
alias edhist='$EDITOR ~/.zsh_history'
alias eddot='edit_in ~/.dotfiles'
alias ednvim='edit_in ~/.config/nvim/ ~/.config/nvim/init.lua'
alias edxmonad='eddot ~/.dotfiles/xmonad/xmonad.symlink/xmonad.hs'
alias edzsh='cd ~/.dotfiles/zsh && $EDITOR zshrc.symlink zshenv.symlink'
alias edaliases='eddot ~/.dotfiles/zsh/aliases.sh'
alias edfuncs='eddot $HOME/.dotfiles/zsh/functions.sh'
alias edXdefaults='eddot -c "set filetype=xdefaults" ~/.dotfiles/Xorg/Xdefaults.symlink'
alias edcompose='eddot ~/.dotfiles/Xorg/XCompose.symlink'
alias edkitty='eddot ~/.dotfiles/kitty/kitty.incfg/kitty.conf'
alias update_kitty='curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin'
#                                                                           }}}1
# General work/writing related                                              {{{1
alias work='cd ~/workspace'
alias seeunimath='xdg-open /home/timtro/Documents/Standards/unimath-symbols.pdf & disown'
alias edtexmf='edit_in ~/texmf/tex/'
alias edbib='edit_in ~/texmf/bibtex/bib ~/texmf/bibtex/bib/library.bib'
alias edepigraphs='edit_in ~/Documents/Writing/Epigraphs ~/Documents/Writing/Epigraphs/Epigraphs.tex'
alias wiki="edit_in ~/Documents/wiki/ ~/Documents/wiki/index.md"
#                                                                           }}}1
# Thesis shortcuts                                                          {{{1
alias thesis='cd ~/Documents/Thesis-PhD'
alias edthesis='thesis && $EDITOR'
alias edbib='thesis && cd sub/bibtex/bib && $EDITOR'
alias edthesis-tex='thesis && cd tex && $EDITOR'
alias edthesis-md='thesis && cd md && $EDITOR'
alias edthesis-reports='thesis && cd reports && $EDITOR'
#                                                                           }}}1
