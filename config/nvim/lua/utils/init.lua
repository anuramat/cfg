-- vim: fdl=0

local M = {}

--- Concatenates `n` copies of `s`
--- @param s string
--- @param n integer
--- @return string
function M.repeat_string(s, n)
  local res = ''
  for _ = 1, n do
    res = res .. s
  end
  return res
end

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

--- Insert an element, if it isn't already in
--- @param tbl table
--- @param elem any
--- @return boolean
function M.insert_unique(tbl, elem)
  for _, v in pairs(tbl) do
    if v == elem then
      return true
    end
  end
  table.insert(tbl, elem)
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
--- @param t table
--- @return table
function M.values(t)
  local result = {}
  for _, value in pairs(t) do
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

--- Merges two tables
--- @param a table
--- @param b table
--- @return table c
function M.merge_two(a, b)
  local c = {}
  for k, v in pairs(a) do
    c[k] = v
  end
  for k, v in pairs(b) do
    c[k] = v
  end
  return c
end

--- Merges tables
--- @param tables table
--- @return table c
function M.merge(tables)
  local c = {}
  for _, v in ipairs(tables) do
    c = M.merge_two(c, v)
  end
  return c
end

--- Joins two lists
--- @param a table
--- @param b table
--- @return table c
function M.join_two(a, b)
  local c = {}
  for i = 1, #a do
    table.insert(c, a[i])
  end
  for i = 1, #b do
    table.insert(c, b[i])
  end
  return c
end

--- Joins tables in a list
--- @param tables table[]
--- @return table c
function M.join_list(tables)
  local c = {}
  for _, v in ipairs(tables) do
    c = M.join_two(c, v)
  end
  return c
end

--- Joins tables
--- @param tables table[]
--- @return table c
function M.join_map(tables)
  local c = {}
  for _, v in pairs(tables) do
    c = M.join_two(c, v)
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

--- Adds prefix to lazy.nvim keymap spec
--- @param lhs_prefix string Prefix to add to mappings
--- @param keys table Lazy.nvim keysmap spec without prefixes
--- @param desc_prefix string Prefix to add to description
--- @return table keys Lazy.nvim keymap spec with prefixes
function M.lazy_prefix(lhs_prefix, keys, desc_prefix)
  for k, _ in pairs(keys) do
    keys[k][1] = lhs_prefix .. keys[k][1]
    keys[k].desc = desc_prefix .. ': ' .. keys[k].desc
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

--- Creates lazy.nvim plugin spec for all depth 2 modules (`plugins` -> `.config/nvim/lua/plugins/*/*`)
--- @param relative_path string Path of a folder in nvim/lua WITHOUT leading/trailing slashes
---@return table imports Import spec for lazy.nvim
function M.make_imports(relative_path)
  local imports = {}
  local ss = { trimempty = true, plain = true }
  local dir = vim.fn.stdpath('config') .. '/lua/' .. relative_path
  local path_lines = vim.fn.glob(dir .. '/*')
  local paths = vim.split(path_lines, '\n', ss)
  for _, path in pairs(paths) do
    local pieces = vim.split(path, '/', ss)
    local name = pieces[#pieces]
    if vim.fn.isdirectory(path) ~= 0 then
      if string.sub(name, -4) ~= '.off' then
        table.insert(imports, { import = relative_path .. '.' .. name })
      end
    else
      if name ~= 'init.lua' then
        error('top-level non-directories in lua/plugins, only init.lua is allowed')
      end
    end
  end
  return imports
end

--- Safely read a buffer local variable
function M.buf_get_var(buffer, key, default)
  local ok, value = pcall(vim.api.nvim_buf_get_var, buffer, key)
  if not ok then
    return default
  end
  return value
end

--- Generate a random [a-zA-Z0-9] string
function M.random_string(length)
  local res = ''
  for _ = 1, length do
    local gen = math.random(10 + 2 * 26)
    local num = 47
    if gen > 36 then
      num = num + 6
    end
    if gen > 10 then
      num = num + 7
    end
    num = num + gen
    res = res .. string.char(num)
  end
  return res
end

--- default on_attach
function M.on_attach(client, buffer)
  require('utils.keys')(buffer)
  require('lsp-format').on_attach(client, buffer)
  vim.lsp.inlay_hint.enable()
end

return M
