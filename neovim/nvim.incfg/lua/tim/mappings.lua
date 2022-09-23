-- vim: fdm=marker:fdc=1

local function set_keymap_from_kv(mode, key, val, opts)
  if type(val) == 'table' then
    val = val[1]
  end
  vim.api.nvim_set_keymap(mode, key, val, opts)
end

-- Load key mappings for a given mode
local function set_maps(mode, keymaps, options)
  local opts = options or { noremap = true, silent = true }
  for k, v in pairs(keymaps) do
    set_keymap_from_kv(mode, k, v, opts)
  end
end

-- Non-plugin keymaps {{{
set_maps('i', {
  -- 'jk' for quitting insert mode
  -- ['jk'] = '<esc>',
  -- 'kj' for quitting insert mode
  -- ['kj'] = '<esc>',
  -- 'jj' for quitting insert mode
  -- ['jj'] = '<esc>',
  -- Navigate tab completion with <c-j> and <c-k>

  -- Make undo breakpoints at punctuation.
  [','] = ',<c-g>u',
  ['.'] = '.<c-g>u',
  ['!'] = '!<c-g>u',
  ['?'] = '?<c-g>u',
})

set_maps('i', {
  -- runs conditionally
  ['<C-j>'] = {
    'pumvisible() ? "\\<C-n>" : "\\<C-j>"',
  },
  ['<C-k>'] = {
    'pumvisible() ? "\\<C-p>" : "\\<C-k>"',
  },
}, {
  expr = true,
  noremap = true,
})

set_maps('n', {
  -- Better window movement
  ['<up>'] = '<C-w>k',
  ['<down>'] = '<C-w>j',
  ['<left>'] = '<C-w>h',
  ['<right>'] = '<C-w>l',

  -- Resize with arrows
  ['<C-Up>'] = ':resize -2<cr>',
  ['<C-Down>'] = ':resize +2<cr>',
  ['<C-Left>'] = ':vertical resize -2<cr>',
  ['<C-Right>'] = ':vertical resize +2<cr>',

  -- Tab switch buffer
  ['<S-l>'] = ':BufferNext<cr>',
  ['<S-h>'] = ':BufferPrevious<cr>',

  -- Clear search hilight and redraw
  ['<C-_>'] = ':nohl<cr><C-L>',
  ['<C-/>'] = ':nohl<cr><C-L>',

  -- Map Y to act like D and C, i.e. to yank until EOL
  ['Y'] = 'y$',

  -- When incremental searching, keep cursor centred:
  -- 'n'/'N'—next/Prev,'zz'—centre, 'zv'—open folds
  ['n'] = 'nzzzv',
  ['N'] = 'Nzzzv',

  -- 'mz'—save mark z, 'J'—join, '`z'—go to mark z.
  ['J'] = 'mzJ`z',

  -- Open new line and go back to normalmode
  ['<A-o>'] = 'o<esc>',
  ['<A-O>'] = 'O<esc>',

  -- Close a buffer without closing the window
  ['<leader>bd'] = ':bp|bd #<cr>',

  -- Clear registers a-z
  ['<leader>cr'] = [[:lua require('tim.functions').cl_alpha_regs()<cr>]],

  -- Cycle foldcolumn size:
  ['<leader>z'] = [[:lua require('tim.settings').cycle_fold_col()<cr>]],
})

set_maps('t', {
  -- Terminal window navigation
  ['<C-h>'] = '<C-\\><C-N><C-w>h',
  ['<C-j>'] = '<C-\\><C-N><C-w>j',
  ['<C-k>'] = '<C-\\><C-N><C-w>k',
  ['<C-l>'] = '<C-\\><C-N><C-w>l',
}, {
  silent = true,
})

set_maps('v', {
  -- Better indenting
  ['<'] = '<gv',
  ['>'] = '>gv',
})

set_maps('x', {
  -- Move selected line / block of text in visual mode
  ['K'] = ":move '<-2<cr>gv-gv",
  ['J'] = ":move '>+1<cr>gv-gv",

  -- Move current line / block with Alt-j/k ala vscode.
  ['<A-j>'] = ":m '>+1<cr>gv-gv",
  ['<A-k>'] = ":m '<-2<cr>gv-gv",
  ['<leader>p'] = [["_dP]], -- don't replace reg when pasting over visal sel.
})
-- }}}

-- Plugin-related keymaps                                                   {{{1
-- Telescope
set_maps('n', {
  ['<leader>ff'] = ':Telescope find_files<cr>',
  ['<leader>fg'] = ':Telescope live_grep<cr>',
  ['<leader>fb'] = ':Telescope buffers<cr>',
  ['<leader>fc'] = ':Telescope bibtex theme=dropdown<cr>',
  ['<leader>fh'] = ':Telescope help_tags<cr>',
  ['<leader>fd'] = ':Telescope lsp_workspace_diagnostics<cr>',
  -- Grep in open files.
  ['<leader>fl'] = ':Telescope live_grep grep_open_files=true<cr>',
  ['<leader>fw'] = [[<cmd>lua require('tim.telescope').grep_wiki()<cr>]],
})

-- RnVimr
set_maps('n', { ['<leader>rr'] = ':RnvimrToggle<cr>' })

-- barbar tabs
set_maps('n', {
  -- ['<A-,>'] = ':BufferPrevious<cr>',
  -- ['<A-.>'] = ':BufferNext<cr>',
  ['<leader>b['] = ':BufferMovePrevious<cr>',
  ['<leader>b]'] = ':BufferMoveNext<cr>',
  ['<A-,>'] = ':BufferMovePrevious<cr>',
  ['<A-.>'] = ':BufferMoveNext<cr>',
  ['<A-c>'] = ':BufferClose<cr>',
  ['<A-1>'] = ':BufferGoto 1<cr>',
  ['<A-2>'] = ':BufferGoto 2<cr>',
  ['<A-3>'] = ':BufferGoto 3<cr>',
  ['<A-4>'] = ':BufferGoto 4<cr>',
  ['<A-5>'] = ':BufferGoto 5<cr>',
  ['<A-6>'] = ':BufferGoto 6<cr>',
  ['<A-7>'] = ':BufferGoto 7<cr>',
  ['<A-8>'] = ':BufferGoto 8<cr>',
  ['<A-9>'] = ':BufferGoto 9<cr>',
  ['<A-0>'] = ':BufferLast<cr>',
  ['<C-p>'] = ':BufferPick<cr>',
  ['<space>bb'] = ':BufferOrderByBufferNumber<cr>',
  ['<space>bd'] = ':BufferOrderByDirectory<cr>',
  ['<space>bl'] = ':BufferOrderByLanguage<cr>',
})

-- Sideways
set_maps('n', {
  ['<leader>mn'] = ':SidewaysLeft<cr>',
  ['<leader>mm'] = ':SidewaysRight<cr>',
})

-- Trouble
set_maps('n', {
  ['<space>t'] = ':TroubleToggle<cr>',
  ['<leader>xx'] = '<cmd>Trouble<cr>',
  ['<leader>xw'] = '<cmd>Trouble lsp_workspace_diagnostics<cr>',
  ['<leader>xd'] = '<cmd>Trouble lsp_document_diagnostics<cr>',
  ['<leader>xl'] = '<cmd>Trouble loclist<cr>',
  ['<leader>xq'] = '<cmd>Trouble quickfix<cr>',
  ['<leader>xt'] = '<cmd>Trouble todo<cr>',
  ['gR'] = '<cmd>Trouble lsp_references<cr>',
})

-- Ranger
set_maps('n', { ['<A-t>'] = ':RnvimrToggle<cr>' })
set_maps('t', {
  ['<A-t>'] = '<M-o> <C-\\><C-n>:RnvimrToggle<cr>',
  ['<A-y>'] = '<C-\\><C-n>:RnvimrResize<cr>',
}, {
  silent = true,
})

-- Utility windows
set_maps('n', {
  ['<space>d'] = ':NvimTreeToggle<cr>',
  ['<space>u'] = ':UndotreeToggle<cr>',
  ['<space>m'] = ':Messages<cr>',
})

-- Coloring and shading plugins:
set_maps('n', {
  ['<leader>tw'] = ':Twilight<cr>',
  ['<leader>tz'] = ':ZenMode<cr>',
  ['<leader>tr'] = ':TransparentToggle<cr>',
})

-- Treesitter hint textobject
set_maps(
  'o',
  { ['m'] = [[:<C-U>lua require('tsht').nodes()<cr>]] },
  { silent = true }
)
set_maps('v', { ['m'] = [[:lua require('tsht').nodes()<cr>]] })

-- nvim-hlslens
vim.cmd [[
noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap * *<Cmd>lua require('hlslens').start()<CR>
noremap # #<Cmd>lua require('hlslens').start()<CR>
noremap g* g*<Cmd>lua require('hlslens').start()<CR>
noremap g# g#<Cmd>lua require('hlslens').start()<CR>
]]

-- vim-chalk
-- set_maps(
--   'v', {
--   ['zf'] = '<Plug>Chalk', -- fold visual selection
--   ['=z'] = '<Plug>ChalkUp', -- Increment current fold level.
--   ['-z'] = '<Plug>ChalkDown', -- Decrement current fold level.
-- })
-- set_maps(
--   'n', {
--   ['zf'] = '<Plug>Chalk', -- fold motion
--   ['zF'] = '<Plug>ChalkRange', -- Fold specified no of lines
--   ['Zf'] = '<Plug>SingleChalk', -- Create opening marker @ cur lvl.
--   ['ZF'] = '<Plug>SingleChalkUp', -- As above at next lvl or specfied lvl.
--   ['=z'] = '<Plug>ChalkUp', -- Increment current fold level.
--   ['-z'] = '<Plug>ChalkDown', -- Decrement current fold level.
-- })
vim.cmd [[
" Create fold at visual selection
vmap zf <Plug>Chalk
" Create fold at operator movement
nmap zf <Plug>Chalk
" Create fold for specified number of lines
nmap zF <Plug>ChalkRange

" Create single (opening) fold marker at current level or specified count
nmap Zf <Plug>SingleChalk
" Create single (opening) fold marker at next levelor specified count
nmap ZF <Plug>SingleChalkUp


" Increment current fold level
nmap =z <Plug>ChalkUp
" Decrement current fold level
nmap -z <Plug>ChalkDown
" Increment levels in selection
vmap =z <Plug>ChalkUp
" Decrement levels in selection
vmap -z <Plug>ChalkDown
]]

-- Redact
vim.cmd [[
nmap <leader>r <Plug>Redact
vmap <leader>r <Plug>Redact
]]

-- luasnip                                                                  {{{2
-- set in ~/.config/nvim/after/plugin/luasnip.lua
vim.keymap.set(
  'n',
  '<leader><leader>s',
  '<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<cr>'
)
--                                                                          }}}2
--                                                                          }}}1
vim.keymap.set(
  'n',
  '<leader><leader>m',
  '<cmd>source ~/.config/nvim/lua/tim/mappings.lua<cr>'
)
