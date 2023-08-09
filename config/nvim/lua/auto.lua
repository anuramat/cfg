-- if quickfix is the only window in this tabpage -- close it
local qf_group = vim.api.nvim_create_augroup('QuickfixKiller', { clear = true })
vim.api.nvim_create_autocmd('WinEnter', {
  group = qf_group,
  callback = function()
    if vim.bo.filetype == "qf" and #vim.api.nvim_tabpage_list_wins(0) == 1 then
      vim.cmd.quit()
    end
  end
})
