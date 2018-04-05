
# Editing and movement shortcuts
alias gnvim='runDetached nvim-gtk'
alias thesis='cd ~/Documents/Thesis-PhD'
alias edthesis='thesis && runDetached nvim-gtk' 
alias edthesis-md='thesis && cd md && runDetached nvim-gtk'
alias edthesis-reports='thesis && cd reports && runDetached nvim-gtk'
alias edepigraphs='cd ~/Documents/Writing/Epigraphs && runDetached nvim-gtk'
alias edtexmf='cd ~/texmf && runDetached nvim-gtk'
alias ednvim='nvim ~/.dotfiles/neovim/nvim.incfg/init.vim'
alias edxmonad='nvim ~/.dotfiles/xmonad/xmonad.symlink/xmonad.hs'
alias edzsh='nvim ~/.dotfiles/zsh/zshrc.symlink'
alias work='cd ~/workspace'


# Utility aliases
alias watch_cpu="watch -n 0 'lscpu | grep MHz'"
alias term_size="echo \(`tput cols` x `tput lines`\)"
alias xrdb-replace='xrdb -remove -all && xrdb -load'

# Theme switching
alias gruv='source "/home/timtro/.config/nvim/bundle/gruvbox/gruvbox_256palette.sh"'
