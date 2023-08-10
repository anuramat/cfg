local M = {}

--- Checks if string is empty
--- @param s string
--- @return boolean is_blank
function M.is_blank(s)
  return s:match('^%s*$') ~= nil
end

--- Check if table contains a specified element
--- @param table table
--- @param elem any
--- @return boolean
function M.contains(table, elem)
  for _, v in pairs(table) do
    if v == elem then
      return true
    end
  end
  return false
end

--- Get indentation of the line under cursor.
--- @return integer indent_level Indentation level in spaces.
function M.get_indent()
  local line_i = vim.api.nvim_win_get_cursor(0)[1] -- Get the current line number
  local line = vim.api.nvim_buf_get_lines(0, line_i - 1, line_i, false)[1] -- Get the current line content
  local ts = vim.api.nvim_buf_get_option(0, 'tabstop') -- Get the current tabstop value

  local spaces = line:match('^ *') or ''
  local tabs = line:match('^\t*') or ''

  local indent_level = #spaces + (#tabs * ts)
  return indent_level
end

--- Removes whitespaces from both sides of the string.
--- @param s string
--- @return string
function M.trim(s)
  return ((s:gsub('^%s+', '')):gsub('%s+$', ''))
end

--- Gets a list of values from a table.
--- @param specs table
--- @return table
function M.values(specs)
  local result = {}
  for _, value in pairs(specs) do
    table.insert(result, value)
  end
  return result
end

--- Simulates key press
--- @param rawkey string Key, e.g. '<c-n>', '<cr>' or 'K'
function M.press(rawkey)
  local key = vim.api.nvim_replace_termcodes(rawkey, true, true, true)
  vim.api.nvim_feedkeys(key, 'n', false)
end

--- Merges tables
--- @param a table
--- @param b table
function M.merge(a, b)
  local c = {}
  for k, v in pairs(a) do
    c[k] = v
  end
  for k, v in pairs(b) do
    c[k] = v
  end
  return c
end

--- Changes CodeLens highlight group
function M.style_codelens()
  local clhl = vim.api.nvim_get_hl(0, { name = 'LspCodeLens' })
  clhl.standout = true
  vim.api.nvim_set_hl(0, 'LspCodeLens', clhl)
end

return M
