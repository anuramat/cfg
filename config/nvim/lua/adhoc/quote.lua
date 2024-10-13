--- Copies the name of the file and the line number to the buffer
--- TODO maybe make it relative to the project folder
local function quote()
  local filename = vim.fn.expand('%')
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local result = filename .. ':' .. tostring(row)
  vim.print(result)
  vim.fn.setreg('+', result)
end

vim.api.nvim_create_user_command('Quote', quote, {})
