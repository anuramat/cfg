local M = {}

--- Whether to hide the module or not
---@param output string
---@param other_height integer height of the other modules
---@return boolean
M.hide = function(output, other_height)
  local lines = vim.split(output, '\n', { trimempty = true })
  local height = #lines
  local win_height = vim.fn.winheight(0)

  local width = 0
  for _, v in ipairs(lines) do
    if #v > width then
      width = #v
    end
  end
  local win_width = vim.fn.winwidth(0)

  return width > win_width or height + other_height >= win_height
end

return M
