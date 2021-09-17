
# Editing and movement shortcuts
alias eddot='edit_in ~/.dotfiles'
alias seeunimath='xdg-open /home/timtro/Documents/Standards/unimath-symbols.pdf & disown'
alias edbib='edit_in ~/texmf/bibtex/bib ~/texmf/bibtex/bib/library.bib'
alias edtexmf='edit_in ~/texmf/tex/'
alias ednvim='edit_in ~/.config/nvim/ ~/.config/nvim/init.lua'
alias edxmonad='eddot ~/.dotfiles/xmonad/xmonad.symlink/xmonad.hs'
alias edzsh='eddot ~/.dotfiles/zsh/zshrc.symlink'
alias edXdefaults='eddot -c "set filetype=xdefaults" ~/.dotfiles/Xorg/Xdefaults.symlink'
alias edcompose='eddot ~/.XCompose'
alias edkitty='eddot ~/.dotfiles/kitty/kitty.incfg/kitty.conf'
alias thesis='cd ~/Documents/Thesis-PhD'
alias edthesis='thesis && $EDITOR'
alias edthesis-tex='thesis && cd tex && $EDITOR'
alias edthesis-md='thesis && cd md && $EDITOR'
alias edthesis-reports='thesis && cd reports && $EDITOR'
alias edepigraphs='edit_in ~/Documents/Writing/Epigraphs ~/Documents/Writing/Epigraphs/Epigraphs.tex'
alias work='cd ~/workspace'

# Utility aliases
alias ls='ls --color=always'
alias watch_cpu="watch -n 0 'lscpu | grep MHz'"
alias lsport="netstat -tulpn"
alias lssock="ss"
alias xrdb-replace='xrdb -remove -all && xrdb -load'
alias Clear="clear && print_greeting"
alias seecompose="$EDITOR /usr/share/X11/locale/en_US.UTF-8/Compose"
alias seekeys="xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'"
alias bat="upower -i /org/freedesktop/UPower/devices/battery_BAT0"

# Required for kitty to ssh properly:
if [ "$TERM" = "xterm-kitty" ]; then
  alias ssh="kitty +kitten ssh"
fi

if which exa >/dev/null; then
  unalias ll
  alias ll="exa -l -g --icons --color=always"
  alias lld="ll --group-directories-first | less"
fi

if which fdfind >/dev/null; then
  alias fd="fdfind"
fi
