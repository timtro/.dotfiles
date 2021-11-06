-- Loading functions borrowed from https://github.com/LunarVim/LunarVim

local generic_opts_any = { noremap = true, silent = true }

local generic_opts = {
  insert_mode = generic_opts_any,
  normal_mode = generic_opts_any,
  visual_mode = generic_opts_any,
  visual_block_mode = generic_opts_any,
  command_mode = generic_opts_any,
  term_mode = { silent = true },
}

local mode_adapters = {
  insert_mode = 'i',
  normal_mode = 'n',
  term_mode = 't',
  visual_mode = 'v',
  visual_block_mode = 'x',
  command_mode = 'c',
}

local function set_keymaps(mode, key, val)
  local opt = generic_opts[mode] and generic_opts[mode] or generic_opts_any
  if type(val) == 'table' then
    opt = val[2]
    val = val[1]
  end
  vim.api.nvim_set_keymap(mode, key, val, opt)
end

-- Load key mappings for a given mode
local function load_mode(mode, keymaps)
  mode = mode_adapters[mode] and mode_adapters[mode] or mode
  for k, v in pairs(keymaps) do
    set_keymaps(mode, k, v)
  end
end

-- Load key mappings for all provided modes
local function load(keymaps)
  for mode, mapping in pairs(keymaps) do
    load_mode(mode, mapping)
  end
end

local keys = {
  insert_mode = {
    -- 'jk' for quitting insert mode
    ['jk'] = '<ESC>',
    -- 'kj' for quitting insert mode
    ['kj'] = '<ESC>',
    -- 'jj' for quitting insert mode
    ['jj'] = '<ESC>',
    -- Following block replaced with matze/vim-move
    -- -- Move current line / block with Alt-j/k ala vscode.
    -- ["<A-j>"] = "<Esc>:m .+1<CR>==gi",
    -- -- Move current line / block with Alt-j/k ala vscode.
    -- ["<A-k>"] = "<Esc>:m .-2<CR>==gi",
    -- navigation
    ['<A-Up>'] = '<C-\\><C-N><C-w>k',
    ['<A-Down>'] = '<C-\\><C-N><C-w>j',
    ['<A-Left>'] = '<C-\\><C-N><C-w>h',
    ['<A-Right>'] = '<C-\\><C-N><C-w>l',
    -- navigate tab completion with <c-j> and <c-k>
    -- runs conditionally
    ['<C-j>'] = {
      'pumvisible() ? "\\<C-n>" : "\\<C-j>"',
      { expr = true, noremap = true },
    },
    ['<C-k>'] = {
      'pumvisible() ? "\\<C-p>" : "\\<C-k>"',
      { expr = true, noremap = true },
    },
  },

  normal_mode = {
    -- Better window movement
    ['<C-h>'] = '<C-w>h',
    ['<C-j>'] = '<C-w>j',
    ['<C-k>'] = '<C-w>k',
    ['<C-l>'] = '<C-w>l',

    -- Resize with arrows
    ['<C-Up>'] = ':resize -2<CR>',
    ['<C-Down>'] = ':resize +2<CR>',
    ['<C-Left>'] = ':vertical resize -2<CR>',
    ['<C-Right>'] = ':vertical resize +2<CR>',

    -- Tab switch buffer
    ['<S-l>'] = ':BufferNext<CR>',
    ['<S-h>'] = ':BufferPrevious<CR>',

    -- Move current line / block with Alt-j/k a la vscode.
    ['<A-j>'] = ':m .+1<CR>==',
    ['<A-k>'] = ':m .-2<CR>==',

    -- Clear search hilight and redraw
    ['<C-_>'] = ':nohl<CR><C-L>',

    -- Map Y to act like D and C, i.e. to yank until EOL
    ['Y'] = 'y$',

    -- Open new line and go back to normalmode
    ['<A-o>'] = 'o<Esc>',
    ['<A-O>'] = 'O<Esc>',
  },

  term_mode = {
    -- Terminal window navigation
    ['<C-h>'] = '<C-\\><C-N><C-w>h',
    ['<C-j>'] = '<C-\\><C-N><C-w>j',
    ['<C-k>'] = '<C-\\><C-N><C-w>k',
    ['<C-l>'] = '<C-\\><C-N><C-w>l',
  },

  visual_mode = {
    -- Better indenting
    ['<'] = '<gv',
    ['>'] = '>gv',
  },

  ---@usage change or add keymappings for visual block mode
  visual_block_mode = {
    -- Move selected line / block of text in visual mode
    ['K'] = ":move '<-2<CR>gv-gv",
    ['J'] = ":move '>+1<CR>gv-gv",

    -- Move current line / block with Alt-j/k ala vscode.
    ['<A-j>'] = ":m '>+1<CR>gv-gv",
    ['<A-k>'] = ":m '<-2<CR>gv-gv",
  },

  command_mode = {},
}

load(keys)

load(keys)

local map = vim.api.nvim_set_keymap
local si_nor = { silent = true, noremap = true }
local noremap = { noremap = true }

-- Easymotion searching
map('', '/', '<Plug>(easymotion-sn)', {})
map('o', '/', '<Plug>(easymotion-tn)', {})
map('', 'n', '<Plug>(easymotion-next)', {})
map('', 'N', '<Plug>(easymotion-prev)', {})
-- Close a buffer without closing the window
map('', '<leader>bd', ':bp|bd #<CR>', si_nor)
-- Telescope
-- map('n', '<c-p>', ':Telescope find_files<cr>', noremap)
map('n', '<leader>ff', ':Telescope find_files<cr>', noremap)
map('n', '<leader>fg', ':Telescope live_grep<cr>', noremap)
map('n', '<leader>fb', ':Telescope buffers<cr>', noremap)
map('n', '<leader>fh', ':Telescope help_tags<cr>', noremap)
-- RnVimr
map('n', '<leader>rr', ':RnvimrToggle<cr>', noremap)
-- Tabtab
map('n', '<A-,>', ':BufferPrevious<CR>', si_nor)
map('n', '<A-.>', ':BufferNext<CR>', si_nor)
map('n', '<A-<>', ':BufferMovePrevious<CR>', si_nor)
map('n', '<A->>', ':BufferMoveNext<CR>', si_nor)
map('n', '<A-c>', ':BufferClose<CR>', si_nor)
map('n', '<A-1>', ':BufferGoto 1<CR>', si_nor)
map('n', '<A-2>', ':BufferGoto 2<CR>', si_nor)
map('n', '<A-3>', ':BufferGoto 3<CR>', si_nor)
map('n', '<A-4>', ':BufferGoto 4<CR>', si_nor)
map('n', '<A-5>', ':BufferGoto 5<CR>', si_nor)
map('n', '<A-6>', ':BufferGoto 6<CR>', si_nor)
map('n', '<A-7>', ':BufferGoto 7<CR>', si_nor)
map('n', '<A-8>', ':BufferGoto 8<CR>', si_nor)
map('n', '<A-9>', ':BufferGoto 9<CR>', si_nor)
map('n', '<A-0>', ':BufferLast<CR>', si_nor)
map('n', '<C-p>', ':BufferPick<CR>', si_nor)
map('n', '<space>bb', ':BufferOrderByBufferNumber<CR>', si_nor)
map('n', '<space>bd', ':BufferOrderByDirectory<CR>', si_nor)
map('n', '<space>bl', ':BufferOrderByLanguage<CR>', si_nor)
-- Sideways
map('n', '<leader>mn', ':SidewaysLeft<cr>', {})
map('n', '<leader>mm', ':SidewaysRight<cr>', {})
-- Trouble
map('n', '<space>t', ':TroubleToggle<cr>', si_nor)
map('n', '<leader>xx', '<cmd>Trouble<cr>', si_nor)
map('n', '<leader>xw', '<cmd>Trouble lsp_workspace_diagnostics<cr>', si_nor)
map('n', '<leader>xd', '<cmd>Trouble lsp_document_diagnostics<cr>', si_nor)
map('n', '<leader>xl', '<cmd>Trouble loclist<cr>', si_nor)
map('n', '<leader>xq', '<cmd>Trouble quickfix<cr>', si_nor)
map('n', '<leader>xt', '<cmd>Trouble todo<cr>', si_nor)
map('n', 'gR', '<cmd>Trouble lsp_references<cr>', si_nor)
-- Ranger
map('n', '<A-t>', ':RnvimrToggle<cr>', si_nor)
map('t', '<A-t>', '<M-o> <C-\\><C-n>:RnvimrToggle<CR>', si_nor)
map('t', '<A-y>', '<C-\\><C-n>:RnvimrResize<CR>', si_nor)
-- TODO: Move keys from gitsigns config to here.
-- Coloring and shading:
map('n', '<leader>tw', ':Twilight<CR>', si_nor)
map('n', '<leader>tz', ':ZenMode<CR>', si_nor)
map('n', '<leader>tr', ':TransparentToggle<CR>', si_nor)
-- nvim-tree
map('n', '<space>r', ':NvimTreeToggle<CR>', si_nor)
-- Minimap
map('n', '<space>p', ':MinimapToggle<cr>', si_nor)
