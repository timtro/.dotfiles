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
  ['jk'] = '<ESC>',
  -- 'kj' for quitting insert mode
  ['kj'] = '<ESC>',
  -- 'jj' for quitting insert mode
  ['jj'] = '<ESC>',
  -- Navigate tab completion with <c-j> and <c-k>
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
  ['<C-Up>'] = ':resize -2<CR>',
  ['<C-Down>'] = ':resize +2<CR>',
  ['<C-Left>'] = ':vertical resize -2<CR>',
  ['<C-Right>'] = ':vertical resize +2<CR>',

  -- Tab switch buffer
  ['<S-l>'] = ':BufferNext<CR>',
  ['<S-h>'] = ':BufferPrevious<CR>',

  -- Clear search hilight and redraw
  ['<C-_>'] = ':nohl<CR><C-L>',

  -- Map Y to act like D and C, i.e. to yank until EOL
  ['Y'] = 'y$',

  -- Open new line and go back to normalmode
  ['<A-o>'] = 'o<Esc>',
  ['<A-O>'] = 'O<Esc>',

  -- Close a buffer without closing the window
  ['<leader>bd'] = ':bp|bd #<CR>',
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
  ['K'] = ":move '<-2<CR>gv-gv",
  ['J'] = ":move '>+1<CR>gv-gv",

  -- Move current line / block with Alt-j/k ala vscode.
  ['<A-j>'] = ":m '>+1<CR>gv-gv",
  ['<A-k>'] = ":m '<-2<CR>gv-gv",
})
-- }}}

-- Plugin-related keymaps {{{
-- Telescope
set_maps('n', {
  ['<leader>ff'] = ':Telescope find_files<cr>',
  ['<leader>fg'] = ':Telescope live_grep<cr>',
  ['<leader>fb'] = ':Telescope buffers<cr>',
  ['<leader>fh'] = ':Telescope help_tags<cr>',
})

-- RnVimr
set_maps('n', { ['<leader>rr'] = ':RnvimrToggle<cr>' })

-- Tabtab
set_maps('n', {
  ['<A-,>'] = ':BufferPrevious<CR>',
  ['<A-.>'] = ':BufferNext<CR>',
  ['<A-<>'] = ':BufferMovePrevious<CR>',
  ['<A->>'] = ':BufferMoveNext<CR>',
  ['<A-c>'] = ':BufferClose<CR>',
  ['<A-1>'] = ':BufferGoto 1<CR>',
  ['<A-2>'] = ':BufferGoto 2<CR>',
  ['<A-3>'] = ':BufferGoto 3<CR>',
  ['<A-4>'] = ':BufferGoto 4<CR>',
  ['<A-5>'] = ':BufferGoto 5<CR>',
  ['<A-6>'] = ':BufferGoto 6<CR>',
  ['<A-7>'] = ':BufferGoto 7<CR>',
  ['<A-8>'] = ':BufferGoto 8<CR>',
  ['<A-9>'] = ':BufferGoto 9<CR>',
  ['<A-0>'] = ':BufferLast<CR>',
  ['<C-p>'] = ':BufferPick<CR>',
  ['<space>bb'] = ':BufferOrderByBufferNumber<CR>',
  ['<space>bd'] = ':BufferOrderByDirectory<CR>',
  ['<space>bl'] = ':BufferOrderByLanguage<CR>',
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
  ['<A-t>'] = '<M-o> <C-\\><C-n>:RnvimrToggle<CR>',
  ['<A-y>'] = '<C-\\><C-n>:RnvimrResize<CR>',
}, {
  silent = true,
})

-- nvim-tree
set_maps('n', { ['<space>d'] = ':NvimTreeToggle<CR>' })

-- Undotree
set_maps('n', { ['<space>u'] = ':UndotreeToggle<CR>' })

-- Coloring and shading plugins:
set_maps('n', {
  ['<leader>tw'] = ':Twilight<CR>',
  ['<leader>tz'] = ':ZenMode<CR>',
  ['<leader>tr'] = ':TransparentToggle<CR>',
})
-- }}}
