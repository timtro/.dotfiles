
# Editing and movement shortcuts
alias g$EDITOR='run_detached $EDITOR-gtk'
alias seeunimath='xdg-open /home/timtro/Documents/Standards/unimath-symbols.pdf'
alias edbib='cd ~/texmf/bibtex/bib && $EDITOR library.bib'
alias edtexmf='cd ~/texmf && $EDITOR'
alias ed$EDITOR='$EDITOR ~/.dotfiles/neovim/$EDITOR.incfg/init.vim'
alias edxmonad='$EDITOR ~/.dotfiles/xmonad/xmonad.symlink/xmonad.hs'
alias edzsh='$EDITOR ~/.dotfiles/zsh/zshrc.symlink'
alias edXdefaults='$EDITOR -c "set filetype=xdefaults" ~/.dotfiles/Xorg/Xdefaults.symlink'
alias edcompose='$EDITOR ~/.XCompose'
alias edkitty='$EDITOR ~/.dotfiles/kitty/kitty.incfg/kitty.conf'
alias edrofi='$EDITOR ~/.dotfiles/rofi/rofi.incfg/config'
alias edrofi-flat='$EDITOR ~/.dotfiles/rofi/rofi.incfg/themes/flat.rasi'
alias thesis='cd ~/Documents/Thesis-PhD'
alias edthesis='thesis && $EDITOR'
alias edthesis-tex='thesis && cd tex && $EDITOR'
alias edthesis-md='thesis && cd md && $EDITOR'
alias edthesis-reports='thesis && cd reports && $EDITOR'
alias edepigraphs='cd ~/Documents/Writing/Epigraphs && $EDITOR'
alias work='cd ~/workspace'

# Utility aliases
alias watch_cpu="watch -n 0 'lscpu | grep MHz'"
alias lsport="netstat -tulpn"
alias lssock="ss"
alias xrdb-replace='xrdb -remove -all && xrdb -load'
alias Clear="clear && print_greeting"
alias seecompose="$EDITOR /usr/share/X11/locale/en_US.UTF-8/Compose"
alias seekeys="xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'"
alias bat="upower -i /org/freedesktop/UPower/devices/battery_BAT0"

# Theme switching
alias gruv='source "/home/timtro/.config/$EDITOR/bundle/gruvbox/gruvbox_256palette.sh"'


# Required for kitty to ssh properly:
alias ssh="kitty +kitten ssh"
