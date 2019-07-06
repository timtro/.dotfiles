"-------------------------------------------------------------------------------
" Features
"
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

""" Be sure Vundle is installed:
if has('nvim')
    let s:editor_root=expand("~/.config/nvim")
else
    let s:editor_root=expand("~/.vim")
endif

let vundle_installed=1
let vundle_readme=s:editor_root . '/bundle/Vundle.vim/README.md'
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    " silent execute "! mkdir -p ~/." . s:editor_path_name . "/bundle"
    silent call mkdir(s:editor_root . '/bundle', "p")
    silent execute "!git clone https://github.com/VundleVim/Vundle.vim "
        \ . s:editor_root . "/bundle/Vundle.vim"
    let vundle_installed=0
endif
filetype off
let &rtp = &rtp . ',' . s:editor_root . '/bundle/Vundle.vim/'
call vundle#rc(s:editor_root . '/bundle')
call vundle#begin()

"-------------------------------------------------------------------------------
""" Plug: Start Vundle Plugin/bundle list.
"""   Options related to plugins are kept near their Plugin delcaration.
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'kien/ctrlp.vim'
  let g:ctrlp_follow_symlinks = 1
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$|build$',
  \ 'file': '\v\.(exe|so|dll)$'
  \ }
" Can also have 'link' in above dict to match symbolic link names.

Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter.git'
  let g:gitgutter_override_sign_column_highlight = 0
Plugin 'easymotion/vim-easymotion'
Plugin 'KabbAmine/vCoolor.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
  let g:airline_powerline_fonts = 1
  let g:airline_detect_modified = 1
  let g:airline#extensions#tabline#enabled = 1
Plugin 'myusuf3/numbers.vim'
  let g:numbers_exclude = ['tagbar', 'gundo', 'minibufexpl', 'nerdtree']
  nnoremap <F5> :NumbersToggle<CR>
  nnoremap <F6> :NumbersOnOff<CR>
Plugin 'qpkorr/vim-bufkill'
Plugin 'junegunn/limelight.vim'
Plugin 'shime/vim-livedown'

""" Plug: The NERDs :)
Plugin 'scrooloose/nerdcommenter'
  let g:NERDCommentEmptyLines = 1
  let g:NERDTrimTrailingWhitespace = 1
  let g:NERDDefaultAlign = 'left'
  let g:NERDSpaceDelims = 1
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
  let g:NERDTreeShowIgnoredStatus = 1
  let g:NERDTreeIgnore = ['\.pyc$']
  " Nerdtree start when file not opened
  " augroup NERDTreeAU
  "   autocmd!
  "   autocmd StdinReadPre * let s:std_in=1
  "   autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  " augroup END
  let g:NERDTreeIndicatorMapCustom = {
      \ "Modified"  : "~",
      \ "Staged"    : "✚",
      \ "Untracked" : "✭",
      \ "Renamed"   : "➜",
      \ "Unmerged"  : "═",
      \ "Deleted"   : "✖",
      \ "Dirty"     : "~",
      \ "Clean"     : "✔︎",
      \ 'Ignored'   : "○",
      \ "Unknown"   : "?"
      \ }

  " Show markers for ignored files?
  " let g:NERDTreeShowIgnoredStatus = 0
  " If yes, make them the colorschemes comment colour:
  hi def link NERDTreeGitStatusIgnored Comment

""" END The NERDs

""" LaTeX related
Plugin 'lervag/vimtex'
let g:tex_flavor = "latex"
let g:vimtex_quickfix_latexlog = {
      \ 'overfull' : 0,
      \ 'underfull' : 0,
      \ 'packages' : {
      \   'default' : 0,
      \ },
      \}
let g:vimtex_quickfix_autoclose_after_keystrokes = 1


Plugin 'glts/vim-texlog.git'

""" Programming
Plugin 'tomtom/tcomment_vim'
Plugin 'rhysd/vim-clang-format'
  let g:clang_format#command = "clang-format-7"
Plugin 'godlygeek/tabular'
" Plugin 'plasticboy/vim-markdown'
"   let g:vim_markdown_folding_disabled = 1
"   let g:vim_markdown_conceal = 0
"   let g:vim_markdown_math = 1
" Plugin 'iamcco/mathjax-support-for-mkdp'
" Plugin 'iamcco/markdown-preview.vim'
"   let g:mkdp_path_to_chrome = "google-chrome"

" Trying bfrg's as alternative with C++20 support
Plugin 'bfrg/vim-cpp-modern'
Plugin 'junegunn/rainbow_parentheses.vim'
  let g:rainbow#max_level = 16
  let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{','}']]
augroup rainbow_langs
  autocmd!
  autocmd FileType c,cpp,haskell,python RainbowParentheses
  autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END
Plugin 'eagletmt/ghcmod-vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'kristijanhusak/vim-carbon-now-sh'


""" Plug: Colorschemes
Plugin 'xterm-color-table.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'rakr/vim-one'
Plugin 'nlknguyen/papercolor-theme'
Plugin 'lokaltog/vim-distinguished'
Plugin 'crusoexia/vim-monokai'
Plugin 'reedes/vim-colors-pencil'
Plugin 'arcticicestudio/nord-vim', { 'on':  'NERDTreeToggle' }
Plugin 'badacadabra/vim-archery'
Plugin 'reewr/vim-monokai-phoenix'
Plugin 'jeetsukumaran/vim-nefertiti'
Plugin 'tpope/vim-vividchalk'
Plugin 'ujihisa/unite-colorscheme'
Plugin 'KeitaNakamura/neodark.vim'
Plugin 'notpratheek/vim-luna'
Plugin 'morhetz/gruvbox'
Plugin 'tomasr/molokai'
Plugin 'nanotech/jellybeans.vim'
Plugin 'fcpg/vim-fahrenheit'
Plugin 'tpope/vim-surround'
Plugin 'Yggdroot/indentLine'
  let g:indentLine_fileTypeExclude = ['markdown']
Plugin 'logico-dev/typewriter'
Plugin 'skielbasa/vim-material-monokai'
Plugin 'beigebrucewayne/Turtles'
Plugin 'yuttie/hydrangea-vim'
Plugin 'nightsense/vimspectr'
Plugin 'atelierbram/Base2Tone-vim'
Plugin 'dylanaraps/wal.vim'
Plugin 'lifepillar/vim-solarized8'
Plugin 'icymind/NeoSolarized'
Plugin 'challenger-deep-theme/vim'
Plugin 'ajmwagar/vim-deus'
Plugin 'dikiaap/minimalist'
Plugin 'cseelus/vim-colors-lucid'
Plugin 'liuchengxu/space-vim-dark'
Plugin 'jacoborus/tender.vim'
Plugin 'rakr/vim-two-firewatch'
Plugin 'wolf-dog/nighted.vim'
Plugin 'treycucco/vim-monotonic'
Plugin 'fxn/vim-monochrome'
Plugin 'szorfein/fromthehell.vim'
Plugin 'andreypopp/vim-colors-plain'
Plugin 'widatama/vim-phoenix'
Plugin 'ninja/sky'

Plugin 'arakashic/chromatica.nvim'
let g:chromatica#libclang_path='/usr/lib/llvm-7/lib/'

Plugin 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
let g:mkdp_browser = 'google-chrome'

""" END colorschemes
"
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"-------------------------------------------------------------------------------
""" General Editor Configuration

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
set textwidth=80
" Indentation settings for using spaces instead of tabs:
set shiftwidth=2
set softtabstop=2
set expandtab
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2
" Display line numbers on the left
set number
" Better command-line completion:
set wildmenu
" Show partial commands in the last line of the screen:
set showcmd
set hlsearch
" Use case insensitive search, except when using capital letters:
set ignorecase
set smartcase
" highlight matching braces
set showmatch
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
" Always show statusline
set laststatus=2
" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler
" Always display the status line, even if only one window is displayed
set laststatus=2
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
" Enable use of the mouse for all modes
set mouse+=a
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
" Use X11 clipboard be default.
" set clipboard=unnamedplus

""" Post Vundle Plugin Config
"-------------------------------------------------------------------------------

" YouCompleteMe :
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" VimTeX
let g:vimtex_complete_close_braces = 1
if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_view_method='zathura'
let g:vimtex_view_forward_search_on_start=1
" Make compiler single shot. No `latexmk -pvc`.
let g:vimtex_compiler_latexmk = {'continuous' : 0}
" Auto indenting on braces makes it very difficult to break text on
" Punctuation.
let g:tex_indent_brace = 0
let g:vimtex_indent_enabled = 0

function SoftWrap()
  " https://agilesysadmin.net/how-to-manage-long-lines-in-vim/
  setlocal colorcolumn=0
  setlocal textwidth=0
  setlocal linebreak
  setlocal showbreak=↪…
  setlocal wrap

  " Navigation:
  nnoremap <buffer> j gj
  nnoremap <buffer> k gk
  vnoremap <buffer> j gj
  vnoremap <buffer> k gk
  nnoremap <buffer> <Down> gj
  nnoremap <buffer> <Up> gk
  vnoremap <buffer> <Down> gj
  vnoremap <buffer> <Up> gk
  inoremap <buffer> <Down> <C-o>gj
  inoremap <buffer> <Up> <C-o>gk
endfunction

augroup general
  autocmd!
  " Automatically deletes all tralling whitespace on save.
  autocmd BufWritePre * %s/\s\+$//e
augroup END

augroup tex
  autocmd!
  autocmd FileType tex set foldmethod=expr foldexpr=vimtex#fold#level(v:lnum)
  "foldtext=vimtex#fold#text)
augroup END

augroup mardown
  autocmd!
  autocmd Filetype markdown
                    \   call SoftWrap()
                    \ | set conceallevel=0
  " autocmd VimResized * if (&columns > 80) | set columns=80 | endif
augroup END

augroup cpp_stuff
  autocmd!
  autocmd FileType c,cpp,objc nnoremap <buffer><Leader>ff :<C-u>ClangFormat<CR>
  autocmd FileType c,cpp,objc vnoremap <buffer><Leader>ff :ClangFormat<CR>
augroup END


""" Aesthetics
"-------------------------------------------------------------------------------

" Set the vertical split character
:set fillchars+=vert:\┃

" let g:indentLine_char = '⎸'
let g:indentLine_char = '▏'

if has("gui_running") || exists('g:GtkGuiLoaded')
  set termguicolors
  source ~/.dotfiles/colours/nvim/dejour-gui.vim
else
  set termguicolors
  set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
  source ~/.dotfiles/colours/nvim/dejour.vim
endif


""" Keybindings
"-------------------------------------------------------------------------------
" NB: urxvt sometimes requires remapping with some exotic combinations,
"     like <C-PageUp>. Appropriate remappings can be found here:
"     <http://vim.wikia.com/wiki/Get_Alt_key_to_work_in_terminal>

" What does semicolon do anyway?
noremap ; :

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> redraw screen and purge search hilighting.
nnoremap <C-L> :nohl<CR><C-L>

" Insert blank space below or above cursor staing in normal mode.
nnoremap <A-o> o<Esc>
nnoremap <A-O> O<Esc>

" Move lines around with alt+…
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Paragraph reformatting
nmap <A-q> gwip
imap <A-q> <C-o>gwip
vmap <A-q> gwip

" Easier buffer slection
noremap <F1> :buffers<CR>:buffer<Space>

" The following requires in Xresrouces/Xdefaults:
" URxvt.keysym.C-Page_Up        : \033[5;5~
" URxvt.keysym.C-Page_Down      : \033[6;5~
nnoremap <C-PageUp> :bprev<CR>
nnoremap <C-PageDown> :bnext<CR>

" Spelling
map <F5> :setlocal spell! spelllang=en_ca<CR>

" Toggle soft wrap.
map <A-z> :setlocal nowrap!<CR>

" Color scheme selection
map <silent><F3> :NEXTCOLOR<cr>
map <silent><F2> :PREVCOLOR<cr>
map <C-n> :NERDTreeToggle<CR>

" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

" Move last word in line to next indented line, and reverse
nmap <C-s> $diw"_xj^hpa<Space><Esc>
nmap <C-A-s> ^diw"_xk$a<Space><Esc>pj^

" Easymotion searching:
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
"
" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

function Make_bg_transparent()
  hi! Normal ctermbg=NONE guibg=NONE
  hi! NonText ctermbg=NONE guibg=NONE
  hi! Conceal ctermbg=NONE guibg=NONE
  " hi clear SignColumn
  " hi! GitGutterAdd ctermbg=NONE guibg=NONE
  " hi! GitGutterChange ctermbg=NONE guibg=NONE
  " hi! GitGutterDelete ctermbg=NONE guibg=NONE
  " hi! GitGutterChangeDelete ctermbg=NONE guibg=NONE
endfunction

function Make_bg_default()
  set background=dark
endfunction

function! Toggle_transparent()
  if g:is_transparent
    call Make_bg_default()
  else
    call Make_bg_transparent()
  endif
  let g:is_transparent = !g:is_transparent
endfunction

nnoremap <C-t> :call Toggle_transparent()<CR>


""" Stuff that just has to go last
"-------------------------------------------------------------------------------

syntax on


let g:tex_conceal = ""
set colorcolumn=81

" For a snappier git gutter:
set updatetime=100

let g:ycm_global_ycm_extra_conf = '/home/timtro/.config/nvim/.ycm_extra_conf.py'


let g:is_transparent=1
" call Make_bg_transparent()

let g:vim_json_syntax_conceal = 0
