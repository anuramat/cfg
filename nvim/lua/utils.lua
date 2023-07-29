local m = {}

m.username = "anuramat"

function m.is_blank(s)
  return s:match("^%s*$") ~= nil
end

function m.print(name, value)
  vim.notify(string.format(name .. ": %s", value))
end

-- Get indentation of the line under cursor (in spaces).
function m.get_indent()
  local line_i = vim.api.nvim_win_get_cursor(0)[1]                         -- Get the current line number
  local line = vim.api.nvim_buf_get_lines(0, line_i - 1, line_i, false)[1] -- Get the current line content
  local ts = vim.api.nvim_buf_get_option(0, "tabstop")                     -- Get the current tabstop value

  local spaces = line:match("^ *") or ""
  local tabs = line:match("^\t*") or ""

  local indent_level = #spaces + (#tabs * ts)
  return indent_level
end

-- Removes whitespaces from both sides of the string.
---@param s string String to be trimmed.
function m.trim(s)
  return s:gsub("^%s+", ""):gsub("%s+$", "")
end

-- gets a list of values from a table
function m.values(specs)
  local result = {}
  for _, value in pairs(specs) do
    table.insert(result, value)
  end
  return result
end

return m
