local u = require('utils')
-- if the only window in this tabpage does not have an actual file as a buffer -- close it
local qf_group = vim.api.nvim_create_augroup('QuickfixKiller', { clear = true })
vim.api.nvim_create_autocmd('WinEnter', {
  group = qf_group,
  callback = function()
    if not vim.bo.modifiable and #vim.api.nvim_tabpage_list_wins(0) == 1 then
      vim.cmd.quit()
    end
  end
})
