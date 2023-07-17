local u = require("utils")
local m = { headerChar = "~" }
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
function m.CreateCommentHeader()
  vim.ui.input({ prompt = "Header text: " }, function(text)
    if text == nil then
      return
    end

    local tw = vim.api.nvim_buf_get_option(0, "textwidth")
    local width = tw - u.get_indent()

    local header = "%s"
    local char = m.headerChar

    local commentString = vim.api.nvim_buf_get_option(0, "commentstring")
    commentString = u.trim(commentString)

    if commentString == "" then
      header = "%s"
    elseif commentString:sub(-2) ~= "%s" then
      header = commentString
    else
      header = commentString .. commentString:reverse():sub(3)
    end
    print(header)
    local width_inner = width - #header + 2
    local header_inner
    if not u.is_blank(text) then
      local half_len = math.floor((width_inner - #text - 2) / 2)
      local l_fill = char:rep(half_len)
      local r_fill = char:rep(width_inner - half_len - #text - 2)
      header_inner = l_fill .. " " .. text .. " " .. r_fill
    else
      header_inner = string.rep(char, width_inner)
    end
    header = string.format(header, header_inner)
    vim.api.nvim_set_current_line(header)
  end)
end

return m
