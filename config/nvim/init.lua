vim.cmd('runtime opts.vim')
require('keys')
if not vim.g.vscode then
  require('lzy')
end
