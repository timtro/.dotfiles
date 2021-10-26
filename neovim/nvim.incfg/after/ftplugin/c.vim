setlocal commentstring=//\ %s

exec 'hi cStatement cterm=italic gui=italic ' .
            \' guifg=' . synIDattr(synIDtrans(hlID('Statement')), 'fg', 'gui') .
            \' ctermfg=' . synIDattr(synIDtrans(hlID('Statement')), 'fg', 'cterm')
