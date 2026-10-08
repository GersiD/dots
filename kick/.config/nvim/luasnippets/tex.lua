local ls = require('luasnip')
local s, i = ls.snippet, ls.insert_node
local fmta = require('luasnip.extras.fmt').fmta
-- proxy defers parsing the body until the snippet is first used or previewed
local sp = require('luasnip.nodes.snippetProxy')

-- treesitter rather than vimtex#syntax#in_mathzone(): the latex parser is active in tex buffers
-- and it switches off the regex syntax that vimtex's check reads
local math_nodes = { inline_formula = true, displayed_equation = true, math_environment = true }

local function in_math()
  local ok, parser = pcall(vim.treesitter.get_parser, 0, 'latex')
  if not ok or not parser then
    return false
  end
  parser:parse()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local node = vim.treesitter.get_node({ pos = { row - 1, math.max(col - 1, 0) } })
  while node do
    local type = node:type()
    if type == 'text_mode' then -- \text{} inside math
      return false
    end
    if math_nodes[type] then
      return true
    end
    node = node:parent()
  end
  return false
end

---@param line_to_cursor string
local function math_only(line_to_cursor)
  -- after a backslash the user is typing the macro by hand; expanding would leave `\\cvar{...}`
  return not line_to_cursor:match('\\%a*$') and in_math()
end

---@param trig string
---@param body string fmta template, `<>` marks each placeholder
---@param defaults string[] placeholder text, selected on jump so typing replaces it
local function math_snip(trig, body, defaults)
  local nodes = {}
  for n, default in ipairs(defaults) do
    nodes[n] = i(n, default)
  end
  return s({ trig = trig, condition = math_only, show_condition = math_only }, fmta(body, nodes))
end

return {
  sp('eqref', [[\eqref{$1}$0]]),
  sp('align', '\\begin{align}\n\t$1\n\\end{align}'),
  sp('leftright()', [[\left($1\right)$0]]),
  -- `\\}` because `\}` is an escaped brace in snippet syntax and would drop the backslash
  sp('leftright{}', [[\left\{$1\right\\}$0]]),
  sp('begin', '\\begin{$1}\n\t$2\n\\end{$1}$0'),
  sp('mathBig', '\\[\n\t$1\n\\]$0'),
  sp('math', [[$$1$$0]]),

  -- risk measures
  math_snip('cvar', '\\cvar{<>}{<>}', { '\\alpha', 'X' }),
  math_snip('var', '\\var{<>}{<>}', { '\\alpha', 'X' }),
  math_snip('evar', '\\evar{<>}{<>}', { '\\alpha', 'X' }),
  math_snip('erm', '\\erm{<>}{<>}', { '\\beta', 'X' }),
  math_snip('gent', '\\gent{<>}{<>}', { '\\alpha', 'X' }),
  math_snip('fdiv', '\\fdiv{<>}{<>}', { '\\alpha', 'X' }),
  math_snip('oce', '\\oce{<>}', { 'X' }),
  math_snip('conc', '\\conc{<>}', { 'X' }),
  math_snip('risk', '\\risk{<>}', { 'X' }),
  math_snip('riskd', '\\riskd{<>}{<>}', { '\\alpha', 'X' }),

  -- expectation and probability
  math_snip('ex', '\\Ex{<>}', { 'X' }),
  math_snip('exp', '\\Exp{<>}{<>}', { '\\pi', 'X' }),
  math_snip('pr', '\\Pr{<>}', { 'X' }),

  -- optimization
  math_snip('argmin', '\\argmin_{<>}', { 'x' }),
  math_snip('argmax', '\\argmax_{<>}', { 'x' }),
  math_snip('sup', '\\sup_{<>}', { 'x' }),
  math_snip('inf', '\\inf_{<>}', { 'x' }),
}, {
  -- autosnippet: `/` isn't a keyword character, so `//` can never show up in the completion menu
  s(
    { trig = '//', wordTrig = false, condition = in_math },
    fmta('\\frac{<>}{<>}', { i(1), i(2) })
  ),
}
