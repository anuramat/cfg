vim.cmd('runtime base.vim')
require('keys')
if not vim.g.vscode then
  require('lzy')
end
