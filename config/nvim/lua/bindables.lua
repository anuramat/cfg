local M = {}
local u = require('utils')

--- Creates comment header I guess.
--- @param chr string Character that fills the header
--- @param width_factor float|nil If present, width = textwidth * width_factor
function M.create_comment_header(chr, width_factor)
  vim.ui.input({ prompt = 'Header text: ' }, function(input)
    -- In case user cancels with escape
    if input == nil then
      return
    end


    -- Get the header format string
    local commentstring = vim.api.nvim_buf_get_option(0, 'commentstring')
    print('' == vim.api.nvim_buf_get_option(0, 'commentstring'))
    commentstring = u.trim(commentstring)
    local header
    if commentstring:sub(-2) == '%s' then
      -- Default case, e.g. python "# comment"
      header = commentstring .. commentstring:reverse():sub(3)
    elseif commentstring == '' then
      -- Plaintext
      header = '%s'
    else
      -- Weird stuff like html "<!-- comment -->"
      header = commentstring
    end

    -- Calculate result width
    local width = vim.api.nvim_buf_get_option(0, 'textwidth')
    if width_factor ~= nil then
      width = math.floor(width * width_factor)
    end
    vim.api.nvim_set_current_line(commentstring)
    vim.cmd('normal ==')
    width = width - u.get_indent()

    -- Insert the filler
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

    header = string.format(header, filling) -- Fill
    vim.api.nvim_set_current_line(header)   -- Overwrite current line with header
    vim.cmd('normal ==')                    -- Fix indenting
  end)
end

return M
