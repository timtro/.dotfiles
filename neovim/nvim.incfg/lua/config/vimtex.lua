-- Bultins
-- vim.g.vimtex_view_method = 'mupdf'
vim.g.vimtex_view_general_viewer = 'evince'
vim.api.nvim_set_keymap('n', '<leader>lv', ':call SVED_Sync()<CR>', {
  -- expr = true,
  noremap = true,
})
-- vim.g.vimtex_view_method = 'zathura'

-- Okular
-- vim.g.vimtex_view_general_viewer = 'okular'
-- vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'

-- qpdfview
-- vim.g.vimtex_view_general_viewer = 'qpdfview'
-- vim.g.vimtex_view_general_options = '--unique @pdf#src:@tex:@line:@col'

vim.g.vimtex_compiler_latexmk = { continuous = 0 }

vim.g.vimtex_fold_enabled = 0
vim.g.vimtex_fold_manual = 1
vim.g.latex_indent_enabled = 0
vim.g.vimtex_complete_enabled = 1
-- vim.g.vimtex_quickfix_enabled = 0
vim.g.vimtex_quickfix_method = 'pplatex'
-- vim.g.vimtex_quickfix_autojump = 1
-- vim.g.vimtex_quickfix_mode = 1
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_toc_config = {
  fold_enable = 0,
  fold_level_start = -1,
  hide_line_numbers = 1,
  hotkeys = 'abcdeilmnopuvxyz',
  hotkeys_enabled = 0,
  hotkeys_leader = ';',
  indent_levels = 0,
  layer_keys = {
    content = 'C',
    include = 'I',
    label = 'L',
    todo = 'T',
  },
  layer_status = {
    content = 1,
    include = 1,
    label = 1,
    todo = 1,
  },
  mode = 1,
  name = 'ToC',
  refresh_always = 1,
  resize = 0,
  show_help = 1,
  show_numbers = 1,
  split_pos = 'above',
  split_width = 30,
  tocdepth = 3,
  todo_sorted = 1,
}

-- vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1

vim.cmd [[
let g:vimtex_complete_ref = {
  \ 'custom_patterns': ['\\\%([FTS]\|def\|thm\|prop\|page\)ref\*\?{[^}]*']
  \ }
]]

vim.api.nvim_set_keymap(
  'n',
  '<Leader>ls',
  ':VimtexStatus<CR>',
  { silent = true }
)

-- For tikzexternalize, to expand memory, need -shell-escape.
--   https://github.com/lervag/vimtex/issues/467#issuecomment-395840260
-- vim.cmd[[
-- let g:vimtex_compiler_latexmk = {
--     \ 'options' : [
--     \   '-pdf',
--     \   '-shell-escape',
--     \   '-verbose',
--     \   '-file-line-error',
--     \   '-synctex=1',
--     \   '-interaction=nonstopmode',
--     \ ],
--     \}
-- ]]
