vim.opt.background = 'dark'
vim.g.material_style = 'deep ocean'

require('material').setup({

	contrast = true, -- Enable contrast for sidebars, floating windows and popup menus like Nvim-Tree
	borders = true, -- Enable borders between verticaly split windows

	italics = {
		comments = false, -- Enable italic comments
		keywords = true, -- Enable italic keywords
		functions = false, -- Enable italic functions
		strings = false, -- Enable italic strings
		variables = false -- Enable italic variables
	},

	contrast_windows = { -- Specify which windows get the contrasted (darker) background
		"terminal", -- Darker terminal background
		"packer", -- Darker packer background
	},

	text_contrast = {
		lighter = false, -- Enable higher contrast text for lighter style
		darker = true -- Enable higher contrast text for darker style
	},

	disable = {
		background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
		term_colors = false, -- Prevent the theme from setting terminal colors
		eob_lines = false -- Hide the end-of-buffer lines
	},

	custom_highlights = {} -- Overwrite highlights with your own
})

vim.cmd[[colorscheme material]]

local material = require'material.colors'


vim.cmd(string.format('highlight IndentBlanklineContextChar guifg=%s gui=nocombine cterm=nocombine',
    material.blue))

local rainbow_colors = {
  material.fg,
	material.blue,
	material.purple,
	material.yellow,
	material.green,
	material.orange,
	material.darkpurple,
	material.darkblue,
	material.darkyellow,
	material.darkgreen,
	material.darkorange
}

(require'colors.rainbow_setter')(rainbow_colors)

vim.api.nvim_set_keymap('n', '<leader>mm', [[<Cmd>lua require('material.functions').toggle_style()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>me', [[<Cmd>lua require('material.functions').toggle_eob()<CR>]], { noremap = true, silent = true })

return { status_theme = 'material-nvim' }
