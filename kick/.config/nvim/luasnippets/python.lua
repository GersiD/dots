-- proxy defers parsing the body until the snippet is first used or previewed
local sp = require('luasnip.nodes.snippetProxy')

---@param trig string
---@param dscr string
---@param lines string[]
local function snip(trig, dscr, lines)
  return sp({ trig = trig, dscr = dscr }, table.concat(lines, '\n'))
end

return {
  snip('#ignore', 'Ignore line for pyright', { '# pyright: ignore$0' }),
  snip('doc', 'Docstring snippet', { '"""', '$0', '"""' }),
  snip('__', 'Create dunder method', { '__${1:init}__$0' }),
  snip('ifmain', 'Execute code if the file is executed directly', {
    'if __name__ == "__main__":',
    '\t${1:main()}',
  }),
  snip('if', 'if statement', { 'if ${1:condition}:', '\t${2:pass}' }),
  snip('elif', 'elif statement', { 'elif ${1:expression}:', '\t${2:pass}' }),
  snip('else', 'else statement', { 'else:', '\t${1:pass}' }),
  snip('ifelse', 'if statement with else', {
    'if ${1:condition}:',
    '\t${2:pass}',
    'else:',
    '\t${3:pass}',
  }),
  snip('match', 'match/case statements', {
    'match ${1:expression}:',
    '\tcase ${2:pattern}:',
    '\t\t${3:pass}',
  }),
  snip('case', 'case block', { 'case ${2:pattern}:', '\t${3:pass}' }),
  snip('casew', 'case wildcard block if other cases fail', { 'case _:', '\t${1:pass}' }),
  snip('while', 'while loop', { 'while ${1:condition}:', '\t${2:pass}' }),
  snip('for', 'for loop', { 'for ${1:value} in ${2:iterable}:', '\t${3:pass}' }),
  snip('forr', 'for loop that iterates over range of integers', {
    'for ${1:value} in range($2):',
    '\t${3:pass}',
  }),
  snip('with', "'with' statement", { 'with ${1:expression} as ${2:target}:', '\t${3:pass}' }),
  snip('lambda', 'lambda statement', { 'lambda ${1:parameter_list}: ${2:expression}' }),
  snip('func', 'Function definition with return type', {
    'def ${1:fname}($2) -> ${3:None}:',
    '\t${4:pass}',
  }),
  snip('class', 'Class definition', { 'class ${1:classname}:', '\t${2:pass}' }),
  snip('classi', 'Class definition template', {
    'class ${1:ClassName}($2):',
    '\t"""${3:docstring for $1.}"""',
    '\tdef __init__(self, ${4:arg}):',
    '\t\t${5:super($1, self).__init__()}',
    '\t\tself.$4 = $4$0',
  }),
  snip('defs', 'Class method definition', {
    'def ${1:mname}(self$2) -> ${3:None}:',
    '\t${4:pass}',
  }),
  snip('property', 'New property: get and set via decorator', {
    '@property',
    'def ${1:pname}(self):',
    '\t"""${2:The $1 property.}"""',
    '\t${3:return self._$1}',
    '',
    '@${4:$1}.setter',
    'def ${5:$1}(self, value):',
    '\t${6:self._$1} = value',
  }),
  snip('except', 'except statement', { 'except$1:', '\t${2:pass}' }),
  snip('exceptas', "'except as' statement", {
    'except ${1:Exception} as ${2:e}:',
    '\t${3:raise $2}',
  }),
  snip('try', 'try/except blocks', {
    'try:',
    '\t${1:pass}',
    'except ${2:Exception} as ${3:e}:',
    '\t${4:raise $3}',
  }),
  snip('trya', 'try/except/else blocks', {
    'try:',
    '\t${1:pass}',
    'except ${2:Exception} as ${3:e}:',
    '\t${4:raise $3}',
    'else:',
    '\t${5:pass}',
  }),
  snip('tryf', 'try/except/finally blocks', {
    'try:',
    '\t${1:pass}',
    'except ${2:Exception} as ${3:e}:',
    '\t${4:raise $3}',
    'finally:',
    '\t${5:pass}',
  }),
  snip('tryef', 'try/except/else/finally blocks', {
    'try:',
    '\t${1:pass}',
    'except${2: ${3:Exception} as ${4:e}}:',
    '\t${5:raise}',
    'else:',
    '\t${6:pass}',
    'finally:',
    '\t${7:pass}',
  }),
}
