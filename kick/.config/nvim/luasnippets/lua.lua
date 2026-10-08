-- proxy defers parsing the body until the snippet is first used or previewed
local sp = require('luasnip.nodes.snippetProxy')

return {
  sp('retlaz', 'return {\n\t$0\n}'),
}
