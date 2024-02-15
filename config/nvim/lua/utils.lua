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

--- Gets plugin paths
--- @param config_prefix string
function M.get_lib_path(config_prefix)
  local paths = vim.api.nvim_get_runtime_file('', true)
  local result = {}
  for _, path in pairs(paths) do
    if not string.find(path, config_prefix) then
      table.insert(result, path)
    end
  end
  return result
end
_G.asdf = M.get_lib_path

--- Adds prefix to lazy.nvim keymap spec
--- @param prefix string Prefix to add to mappings
--- @param keys table Lazy.nvim keysmap spec without prefixes
--- @return table keys Lazy.nvim keymap spec with prefixes
function M.prefix(prefix, keys)
  for k, _ in pairs(keys) do
    keys[k][1] = prefix .. keys[k][1]
  end
  return keys
end

--- Prints the number of lines in the buffer
--- @param bufnr integer Buffer number
function M.buf_lines_len(bufnr)
  local file = vim.api.nvim_buf_get_name(bufnr)
  local wc_output = vim.fn.system({ 'wc', '-l', file })
  local raw_len = wc_output:match('%d+')
  return tonumber(raw_len)
end

return M
