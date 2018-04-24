
# Editing and movement shortcuts
alias gnvim='run_detached nvim-gtk'
alias thesis='cd ~/Documents/Thesis-PhD'
alias edthesis='thesis && run_detached nvim-gtk' 
alias edthesis-md='thesis && cd md && run_detached nvim-gtk'
alias edthesis-reports='thesis && cd reports && run_detached nvim-gtk'
alias edepigraphs='cd ~/Documents/Writing/Epigraphs && run_detached nvim-gtk'
alias edtexmf='cd ~/texmf && run_detached nvim-gtk'
alias ednvim='nvim ~/.dotfiles/neovim/nvim.incfg/init.vim'
alias edxmonad='nvim ~/.dotfiles/xmonad/xmonad.symlink/xmonad.hs'
alias edzsh='nvim ~/.dotfiles/zsh/zshrc.symlink'
alias edXdefaults='nvim -c "set filetype=xdefaults" ~/.dotfiles/Xorg/Xdefaults.symlink'
alias edkitty='nvim ~/.dotfiles/kitty/kitty.incfg/kitty.conf'
alias work='cd ~/workspace'


# Utility aliases
alias watch_cpu="watch -n 0 'lscpu | grep MHz'"
alias xrdb-replace='xrdb -remove -all && xrdb -load'

# Theme switching
alias gruv='source "/home/timtro/.config/nvim/bundle/gruvbox/gruvbox_256palette.sh"'
