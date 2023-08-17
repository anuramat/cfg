require('keys')
vim.cmd('runtime opts.vim')
require('auto')
if not vim.g.vscode then
  require('lzy')
end
