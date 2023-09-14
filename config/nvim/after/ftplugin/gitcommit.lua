local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, true)[1]
if first_line == '' then
  vim.print('asdfasdf')
  local branch = vim.fn.system({ 'git', 'branch', '--show-current' })
  local ticket = string.match(branch, '%u+-%d+')
  if ticket ~= nil then
    local template = '[' .. ticket .. ']'
    vim.api.nvim_buf_set_lines(0, 0, 1, true, { template })
  end
end
