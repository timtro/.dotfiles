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
    -- Navigate tab completion with <c-j> and <c-k>
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

-- TODO: port the following mappings to the structure to minimize repetition

local map = vim.api.nvim_set_keymap
local si_nor = { silent = true, noremap = true }
local noremap = { noremap = true }

-- local function nmap(lhs, rhs, opts)
--   return vim.api.nvim_set_keymap('n', lhs, rhs, opts)
-- end

-- local function nmapp(lhs, rhs)
--   return vim.api.nvim_set_keymap('n', lhs, rhs, {})
-- end

local function nnoremap(lhs, rhs)
  return vim.api.nvim_set_keymap('n', lhs, rhs, {noremap = true})
end

-- Close a buffer without closing the window
nnoremap('<leader>bd', ':bp|bd #<CR>')
-- Telescope
-- map('n', '<c-p>', ':Telescope find_files<cr>', noremap)
nnoremap('<leader>ff', ':Telescope find_files<cr>')
nnoremap('<leader>fg', ':Telescope live_grep<cr>')
nnoremap('<leader>fb', ':Telescope buffers<cr>')
nnoremap('<leader>fh', ':Telescope help_tags<cr>')
-- RnVimr
nnoremap('<leader>rr', ':RnvimrToggle<cr>')
-- Tabtab
nnoremap('<A-,>', ':BufferPrevious<CR>')
nnoremap('<A-.>', ':BufferNext<CR>')
nnoremap('<A-<>', ':BufferMovePrevious<CR>')
nnoremap('<A->>', ':BufferMoveNext<CR>')
nnoremap('<A-c>', ':BufferClose<CR>')
nnoremap('<A-1>', ':BufferGoto 1<CR>')
nnoremap('<A-2>', ':BufferGoto 2<CR>')
nnoremap('<A-3>', ':BufferGoto 3<CR>')
nnoremap('<A-4>', ':BufferGoto 4<CR>')
nnoremap('<A-5>', ':BufferGoto 5<CR>')
nnoremap('<A-6>', ':BufferGoto 6<CR>')
nnoremap('<A-7>', ':BufferGoto 7<CR>')
nnoremap('<A-8>', ':BufferGoto 8<CR>')
nnoremap('<A-9>', ':BufferGoto 9<CR>')
nnoremap('<A-0>', ':BufferLast<CR>')
nnoremap('<C-p>', ':BufferPick<CR>')
nnoremap('<space>bb', ':BufferOrderByBufferNumber<CR>')
nnoremap('<space>bd', ':BufferOrderByDirectory<CR>')
nnoremap('<space>bl', ':BufferOrderByLanguage<CR>')
-- Sideways
nnoremap('<leader>mn', ':SidewaysLeft<cr>')
nnoremap('<leader>mm', ':SidewaysRight<cr>')
-- Trouble
nnoremap('<space>t', ':TroubleToggle<cr>')
nnoremap('<leader>xx', '<cmd>Trouble<cr>')
nnoremap('<leader>xw', '<cmd>Trouble lsp_workspace_diagnostics<cr>')
nnoremap('<leader>xd', '<cmd>Trouble lsp_document_diagnostics<cr>')
nnoremap('<leader>xl', '<cmd>Trouble loclist<cr>')
nnoremap('<leader>xq', '<cmd>Trouble quickfix<cr>')
nnoremap('<leader>xt', '<cmd>Trouble todo<cr>')
nnoremap('gR', '<cmd>Trouble lsp_references<cr>')
-- Ranger
nnoremap('<A-t>', ':RnvimrToggle<cr>')
map('t', '<A-t>', '<M-o> <C-\\><C-n>:RnvimrToggle<CR>', si_nor)
map('t', '<A-y>', '<C-\\><C-n>:RnvimrResize<CR>', si_nor)
-- nvim-tree
nnoremap('<space>d', ':NvimTreeToggle<CR>')
-- Undotree
nnoremap('<space>u', ':UndotreeToggle<CR>')
-- Coloring and shading plugins:
nnoremap('<leader>tw', ':Twilight<CR>')
nnoremap('<leader>tz', ':ZenMode<CR>')
nnoremap('<leader>tr', ':TransparentToggle<CR>')
