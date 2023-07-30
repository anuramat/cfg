local M = {}

local u = require("utils")

local header_char = "~"
function M.create_comment_header()
  vim.ui.input({ prompt = "Header text: " }, function(input)
    if input == nil then
      return
    end

    local tw = vim.api.nvim_buf_get_option(0, "textwidth")
    local width = tw - u.get_indent()
    local header = "%s"
    local char = header_char

    local commentstring = vim.api.nvim_buf_get_option(0, "commentstring")
    commentstring = u.trim(commentstring)

    if commentstring == "" then
      header = "%s"
    elseif commentstring:sub(-2) ~= "%s" then
      header = commentstring
    else
      header = commentstring .. commentstring:reverse():sub(3)
    end

    local width_inner = width - #header + 2
    local header_inner
    if not u.is_blank(input) then
      local half_len = math.floor((width_inner - #input - 2) / 2)
      local l_fill = char:rep(half_len)
      local r_fill = char:rep(width_inner - half_len - #input - 2)
      header_inner = l_fill .. " " .. input .. " " .. r_fill
    else
      header_inner = string.rep(char, width_inner)
    end

    header = string.format(header, header_inner)
    vim.api.nvim_set_current_line(header)
  end)
end

return M
