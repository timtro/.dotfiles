require("transparent").setup({
  enable = false, -- boolean: enable transparent
  extra_groups = { -- table/string: additional groups that should be clear
    -- In particular, when you set it to 'all', that means all avaliable groups
    "lualine_c_normal"
  },
  exclude = {}, -- table: groups you don't want to clear
})
