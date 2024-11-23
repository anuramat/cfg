-- vim: fdl=0

local M = {}

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

--- Removes whitespaces from both sides of the string.
--- @param s string
--- @return string
function M.trim(s)
  return ((s:gsub('^%s+', '')):gsub('%s+$', ''))
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

--- Default 'on_attach' function
function M.on_attach(client, buffer)
  require('utils.keys')(buffer)
  require('lsp-format').on_attach(client, buffer)
  vim.lsp.inlay_hint.enable()
end

--- Generates a banner with a random font
---@param text string
---@param font? string
---@return string
function M.figlet(text, font)
  if not font then
    -- hehe
    local font_cmd =
      [[figlist | sed -n '/Figlet fonts in this directory:/,/Figlet control files in this directory:/{//!p}' | shuf | head -n 1]]
    local font_res = vim.system({ 'bash', '-c', font_cmd }, { text = true }):wait()
    font = M.trim(font_res.stdout)
  end
  vim.g.figlet_font = font
  local figlet_res = vim.system({ 'figlet', '-w', '999', '-f', font, text }, { text = true }):wait()
  return figlet_res.stdout
end

function M.version_string()
  local version = vim.version()
  local nvim_version_info = ' ' .. version.major .. '.' .. version.minor .. '.' .. version.patch
  return nvim_version_info
end

function M.press(rawkey)
  local key = vim.api.nvim_replace_termcodes(rawkey, true, true, true)
  vim.api.nvim_feedkeys(key, 'n', false)
end

return M
