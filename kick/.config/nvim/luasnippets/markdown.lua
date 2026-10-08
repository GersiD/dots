-- proxy defers parsing the body until the snippet is first used or previewed
local sp = require('luasnip.nodes.snippetProxy')

---@param trig string
---@param kind string admonition type, e.g. `ad-note`
local function admonition(trig, kind)
  return sp(trig, '```' .. kind .. '\n $1\n```$0')
end

return {
  admonition('note', 'ad-note'),
  admonition('tldr', 'ad-tldr'),
  admonition('todo', 'ad-todo'),
  admonition('hint', 'ad-hint'),
  admonition('done', 'ad-done'),
  admonition('faq', 'ad-faq'),
  admonition('warn', 'ad-warning'),
  admonition('danger', 'ad-danger'),
  admonition('example', 'ad-example'),
  admonition('info', 'ad-info'),

  sp('link', '[${1:Link Text}](${2:URL})$0'),
  sp('tab1col', '| ${1:Col} |\n| --- |\n| ${2:Val} |'),
  sp('tab2col', '| ${1:Col1} | ${2:Col2} |\n| --- | --- |\n| ${3:Val1} | ${4:Val2} |'),
  sp('tab3col', '| ${1:Col1} | ${2:Col2} | ${3:Col3} |\n| --- | --- | --- |\n| ${4:Val1} | ${5:Val2} | ${6:Val3} |'),
}
