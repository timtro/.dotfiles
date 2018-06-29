
# Editing and movement shortcuts
alias gnvim='run_detached nvim-gtk'
alias thesis='cd ~/Documents/Thesis-PhD'
alias edthesis='thesis && $EDITOR'
alias edthesis-md='thesis && cd md && $EDITOR'
alias edthesis-reports='thesis && cd reports && $EDITOR'
alias edepigraphs='cd ~/Documents/Writing/Epigraphs && $EDITOR'
alias edtexmf='cd ~/texmf && $EDITOR'
alias ednvim='nvim ~/.dotfiles/neovim/nvim.incfg/init.vim'
alias edxmonad='nvim ~/.dotfiles/xmonad/xmonad.symlink/xmonad.hs'
alias edzsh='nvim ~/.dotfiles/zsh/zshrc.symlink'
alias edXdefaults='nvim -c "set filetype=xdefaults" ~/.dotfiles/Xorg/Xdefaults.symlink'
alias edkitty='nvim ~/.dotfiles/kitty/kitty.incfg/kitty.conf'
alias edrofi='nvim ~/.dotfiles/rofi/rofi.incfg/config'
alias edrofi-flat='nvim ~/.dotfiles/rofi/rofi.incfg/themes/flat.rasi'
alias work='cd ~/workspace'


# Utility aliases
alias watch_cpu="watch -n 0 'lscpu | grep MHz'"
alias lsport="netstat -tulpn"
alias lssock="ss"
alias xrdb-replace='xrdb -remove -all && xrdb -load'
alias Clear="clear && print_greeting"

# Theme switching
alias gruv='source "/home/timtro/.config/nvim/bundle/gruvbox/gruvbox_256palette.sh"'

# Required for kitty to ssh properly:
alias ssh="kitty +kitten ssh"
