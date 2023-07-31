local M = {}

local u = require 'utils'

--- Creates comment header I guess.
--- @param chr string Character that fills the header
--- @param adjust_width boolean Whether to adjust the header width to indentation
function M.create_comment_header(chr, adjust_width)
  vim.ui.input({ prompt = 'Header text: ' }, function(input)
    -- in case user cancels with escape
    if input == nil then
      return
    end

    -- calculate result width
    local width = vim.api.nvim_buf_get_option(0, 'textwidth')
    if adjust_width then
      width = width - u.get_indent()
    end

    -- get the header format string
    local commentstring = vim.api.nvim_buf_get_option(0, 'commentstring')
    commentstring = u.trim(commentstring)
    local header = '%s'
    if commentstring == '' then
      header = '%s'
    elseif commentstring:sub(-2) ~= '%s' then
      header = commentstring
    else
      header = commentstring .. commentstring:reverse():sub(3)
    end

    -- make the filling
    local filling_width = width - #header + 2
    local filling
    if not u.is_blank(input) then
      local half_len = math.floor((filling_width - #input - 2) / 2)
      local l_fill = chr:rep(half_len)
      local r_fill = chr:rep(filling_width - half_len - #input - 2)
      filling = l_fill .. ' ' .. input .. ' ' .. r_fill
    else
      filling = string.rep(chr, filling_width)
    end

    header = string.format(header, filling) -- fill
    vim.api.nvim_set_current_line(header)   -- overwrite current line with header
    vim.cmd('normal ==')                    -- fix indenting
  end)
end

return M
