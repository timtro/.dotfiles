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

local same = RL('tim.snippets').same

-- local snippets, autosnippets = {}, {}

local snippets = {
  ls.parser.parse_snippet(
    { trig = 'emph', name = 'Emphasis' },
    '\\emph{${1:${TM_SELECTED_TEXT}}} $0'
  ),
  ls.parser.parse_snippet({
    trig = 'inar',
    name = 'Inline function arrow',
  }, '\\begin{tikzcd}[cramped, sep=small] $1 \\rar["$2"] & $3 \\end{tikzcd}$0'),
  ls.parser.parse_snippet(
    { trig = 'lr(', name = 'left( right)' },
    '\\left( ${1:${TM_SELECTED_TEXT}} \\right) $0'
  ),
  ls.parser.parse_snippet(
    { trig = 'biglr(', name = 'bigl( bigr)' },
    '\\left( ${1:${TM_SELECTED_TEXT}} \\right) $0'
  ),
  ls.parser.parse_snippet(
    { trig = 'lr{', name = 'left{ right}' },
    '\\left\\{ ${1:${TM_SELECTED_TEXT}} \\right\\\\} $0'
  ),
  ls.parser.parse_snippet(
    { trig = 'biglr{', name = 'bigl{ bigr}' },
    '\\bigl\\{ ${1:${TM_SELECTED_TEXT}} \\bigr\\\\} $0'
  ),
  ls.parser.parse_snippet(
    { trig = 'lr[', name = 'left[ right]' },
    '\\left[ ${1:${TM_SELECTED_TEXT}} \\right] $0'
  ),
  ls.parser.parse_snippet(
    { trig = 'biglr[', name = 'bigl[ bigr]' },
    '\\bigl[ ${1:${TM_SELECTED_TEXT}} \\bigr] $0'
  ),
}

local autosnippets = {
  s(
    { trig = 'em|(.+)|', regTrig = true, name = 'Emphasis shorthand' },
    f(function(_, snip)
      return '\\emph{' .. snip.captures[1] .. '}'
    end)
  ),
  ls.parser.parse_snippet(
    { trig = 'beg', name = 'begin{} / end{}' },
    '\\begin{$1}\n\t$0\n\\end{$1}'
  ),
  s(
    { trig = 'ali', name = 'Align' },
    { t { '\\begin{align*}', '\t' }, i(1), t { '', '\\end{align*}' } }
  ),
}

return snippets, autosnippets
