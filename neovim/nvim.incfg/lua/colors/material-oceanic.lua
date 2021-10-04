vim.opt.background = 'dark'
vim.g.material_style = 'oceanic'

vim.g.material_contrast = true -- Bars and menus like nvim-tree and telescope have a different background
vim.g.material_lighter_contrast = false
vim.g.material_italic_strings = false
vim.g.material_italic_comments = false
vim.g.material_italic_keywords = false
vim.g.material_italic_functions = false
vim.g.material_italic_variables = false
vim.g.material_borders = false -- Enable the border between verticaly split windows visable
vim.g.material_disable_background = false -- transparent bg
vim.g.material_disable_terminal = false
vim.g.material_hide_eob = false -- Hide the end of buffer lines ( ~ )
vim.g.material_variable_color = '#717CB4' -- Set a custom color for variables and fields
vim.g.material_custom_colors = {} -- e.g. { black = "#000000", bg = "#0F111A" }

-- require('material').set()

vim.api.nvim_set_keymap('n', '<leader>mm', [[<Cmd>lua require('material.functions').toggle_style()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>me', [[<Cmd>lua require('material.functions').toggle_eob()<CR>]], { noremap = true, silent = true })
