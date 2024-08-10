-- vim: fdm=marker:fdc=2:fmr=<<<,>>>

print("Loading LaTeX Snips")

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

-- Manual (non-auto) snips                                                  <<<1
local snippets = {
  ls.parser.parse_snippet(
    { trig = 'emph', name = 'Emphasis' },
    '\\emph{${1:${TM_SELECTED_TEXT}}}$0'
  ),
  ls.parser.parse_snippet(
    { trig = 'bf', name = 'Boldface' },
    '\\textbf{${1:${TM_SELECTED_TEXT}}} $0'
  ),
  ls.parser.parse_snippet({
    trig = 'cdar',
    name = 'Inline function arrow',
  }, '\\begin{tikzcd}[cramped, sep=small] $1 \\ar[r, "$2"] & $3 \\end{tikzcd}$0'),
  ls.parser.parse_snippet(
    { trig = 'lr(', name = 'left( right)' },
    '\\left( ${1:${TM_SELECTED_TEXT}} \\right) $0'
  ),
  ls.parser.parse_snippet(
    { trig = 'biglr(', name = 'bigl( bigr)' },
    '\\bigl( ${1:${TM_SELECTED_TEXT}} \\bigr) $0'
  ),
  ls.parser.parse_snippet(
    { trig = 'Biglr(', name = 'Bigl( Bigr)' },
    '\\Bigl( ${1:${TM_SELECTED_TEXT}} \\Bigr) $0'
  ),
  ls.parser.parse_snippet(
    { trig = 'bigglr(', name = 'biggl( biggr)' },
    '\\biggl( ${1:${TM_SELECTED_TEXT}} \\biggr) $0'
  ),
  ls.parser.parse_snippet(
    { trig = 'Biggglr(', name = 'Biggl( Biggr)' },
    '\\Biggl( ${1:${TM_SELECTED_TEXT}} \\Biggr) $0'
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
  ls.parser.parse_snippet(
    { trig = 'vfill', name = 'Vertical fill' },
    '\\vspace*{\\fill}'
  ),
  ls.parser.parse_snippet(
    {
      trig = 'fun-def-mapsto-brace',
      name = 'Function definition with braced mapsto',
    },
    '\\begin{align*}'
    .. '\n\t$1 \\⦂ $2 &→ $3 \\\\\\'
    .. '\n\t\\left\\{\\'
    .. '\n\t\t\\begin{aligned}'
    .. '\n\t\t\t$4 \\\\\\'
    .. '\n\t\t\t$5'
    .. '\n\t\t\\end{aligned}'
    .. '\n\t\t\\right.&'
    .. '\n\t\t\\begin{aligned}'
    .. '\n\t\t\t&↦ $6\\\\\\'
    .. '\n\t\t\t&↦ $7'
    .. '\n\t\t\\end{aligned}'
    .. '\n\\end{align*}'
  ),
  ls.parser.parse_snippet(
    { trig = 'fun-def', name = 'Formal function definition with mapsto' },
    '\\begin{align*}'
    .. '\n\t$1 \\⦂ $2 &→ $3 \\\\\\'
    .. '\n\t\t$4 &↦ $5'
    .. '\n\\end{align*}'
  ),
-- Beamer related                                                           <<<2
  ls.parser.parse_snippet(
    { trig = 'bmfr', name = 'Empty Beamer frame' },
    '\\begin{frame}\n\t$0\n\\end{frame}'
  ),
  ls.parser.parse_snippet(
    { trig = 'bmit', name = 'Beamer frame with itemization' },
    '\\begin{frame}'
    .. '\n\t\\begin{itemize}$0'
    .. '\n\t\\end{itemize}\n'
    .. '\\end{frame}'
  ),
  ls.parser.parse_snippet(
    { trig = 'bmma', name = 'Beamer frame with displaymath' },
    '\\begin{frame}\n\t\\[$0\n\t\\]\n\\end{frame}'
  ),
  ls.parser.parse_snippet(
    { trig = 'bmtk', name = 'Beamer frame with TikZ environment' },
    '\\begin{frame}'
    .. '\n\t\\['
    .. '\n\t\t\\begin{tikzpicture}$0'
    .. '\n\t\t\\end{tikzpicture}'
    .. '\n\t\\]\n'
    .. '\\end{frame}'
  ),
--                                                                          >>>2
}
--                                                                          >>>1
-- Autosnips                                                                <<<1
local autosnippets = {
  s(
    { trig = 'em|(.+)|', regTrig = true, name = 'Emphasis' },
    f(function(_, snip)
      return '\\emph{' .. snip.captures[1] .. '}'
    end)
  ),
  s(
    { trig = 'bf|(.+)|', regTrig = true, name = 'Bolf font' },
    f(function(_, snip)
      return '\\textbf{' .. snip.captures[1] .. '}'
    end)
  ),
  s(
    { trig = 'bfem|(.+)|', regTrig = true, name = 'Bold font with emphasis' },
    f(function(_, snip)
      return '\\bfemph{' .. snip.captures[1] .. '}'
    end)
  ),
  s(
    { trig = 'tt|(.+)|', regTrig = true, name = 'Typewriter text' },
    f(function(_, snip)
      return '\\texttt{' .. snip.captures[1] .. '}'
    end)
  ),
  s(
    { trig = 'mtt|(.+)|', regTrig = true, name = 'Mathmode typewriter text' },
    f(function(_, snip)
      return '\\mathtt{' .. snip.captures[1] .. '}'
    end)
  ),
  s(
    { trig = 'mttx|(.+)|', regTrig = true, name = 'Mathmode typewriter text' },
    f(function(_, snip)
      return '\\text{\\texttt{' .. snip.captures[1] .. '}}'
    end)
  ),
  s(
    { trig = 'txt|(.+)|', regTrig = true, name = 'Mathmode text' },
    f(function(_, snip)
      return '\\text{' .. snip.captures[1] .. '}'
    end)
  ),
  s(
    { trig = '"|(.+)|', regTrig = true, name = 'Double quote' },
    f(function(_, snip)
      return '“' .. snip.captures[1] .. '”'
    end)
  ),
  ls.parser.parse_snippet(
    { trig = 'bgin', name = 'begin{} / end{}' },
    '\\begin{$1}\n\t${2:${TM_SELECTED_TEXT}}\n\\end{$1}'
  ),
  s(
    { trig = 'beali', name = 'Align' },
    { t { '\\begin{align*}', '\t' }, i(1), t { '', '\\end{align*}' } }
  ),
}
--                                                                          >>>1
--
return snippets, autosnippets
