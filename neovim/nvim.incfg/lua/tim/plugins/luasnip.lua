return {
  'L3MON4D3/LuaSnip',
  build = "make install_jsregexp",
  config = function ()
    local ls = require 'luasnip'
    local types = require("luasnip.util.types")

    ls.setup {
      history = false,
      -- Update more often, :h events for more info.
      -- update_events = 'TextChanged,TextChangedI',
      -- Snippets aren't automatically removed if their text is deleted.
      -- `delete_check_events` determines on which events (:h events) a check for
      -- deleted snippets is performed.
      -- This can be especially useful when `history` is enabled.
      -- delete_check_events = 'TextChanged',
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { 'choiceNode', 'Comment' } },
          },
        },
      },
      -- treesitter-hl has 100, use something higher (default is 200).
      ext_base_prio = 300,
      -- minimal increase in priority.
      ext_prio_increase = 1,
      enable_autosnippets = true,
      -- mapping for cutting selected text so it's usable as SELECT_DEDENT,
      -- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
      store_selection_keys = '<tab>',
      -- luasnip uses this function to get the currently active filetype. This
      -- is the (rather uninteresting) default, but it's possible to use
      -- eg. treesitter for getting the current filetype by setting ft_func to
      -- require("luasnip.extras.filetype_functions").from_cursor (requires
      -- `nvim-treesitter/nvim-treesitter`). This allows correctly resolving
      -- the current filetype in eg. a markdown-code block or `vim.cmd()`.
      ft_func = function()
        return vim.split(vim.bo.filetype, '.', true)
      end,
    }

    -- this will expand the current item or jump to the next.
    vim.keymap.set({ "i", "s" }, "<C-l>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true })

    -- this moves to the previous item within the snippet
    vim.keymap.set({ "i", "s" }, "<C-h>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })

    vim.keymap.set("i", "<C-<tab>>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end)

    require('luasnip.loaders.from_lua').load {
      paths = { '~/.config/nvim/lua/tim/snippets/ft' },
    }

  end
}
