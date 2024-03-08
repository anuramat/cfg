vim.cmd('runtime base.vim')
if vim.g.neovide then
  require('neovide')
end
require('adhoc')
require('lzy')

-- require('cfg_debug').debug_events({ 'BufReadPre', 'BufNewFile' })
