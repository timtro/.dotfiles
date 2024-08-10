local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require 'luasnip.util.events'
local ai = require 'luasnip.nodes.absolute_indexer'
local fmt = require('luasnip.extras.fmt').fmt
local extras = require 'luasnip.extras'
local m = extras.m
local l = extras.l
local rep = extras.rep
local postfix = require('luasnip.extras.postfix').postfix

-- local same = RL('tim.snippets').same

-- local snippets, autosnippets = {}, {}

-- Non-auto snippets                                                        {{{1
local snippets = {
  ls.parser.parse_snippet(
    { trig = 'pr', name = 'print(…)' },
    'print(${1:${TM_SELECTED_TEXT}}$0)'
  ),
--                                                                          }}}2
}
--                                                                          }}}1
-- Autosnippets{{{
local autosnippets = {}
-- }}}

return snippets, autosnippets
