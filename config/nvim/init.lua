vim.cmd('runtime base.vim')
require('adhoc')
if not vim.g.vscode then
  require('lzy')
end
