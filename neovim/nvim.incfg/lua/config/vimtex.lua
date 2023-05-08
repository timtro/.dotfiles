-- Bultins
-- vim.g.vimtex_view_method = 'mupdf'
-- vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_view_method = 'zathura'

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
vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1

vim.cmd[[
let g:vimtex_complete_ref = {
  \ 'custom_patterns': ['\\[DNBXFA]ref\*\?{[^}]*$']
  \ }
]]

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
