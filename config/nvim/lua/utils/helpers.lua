-- vim: fdl=0

local M = {}

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

--- Simulates keypresses
function M.press(rawkey)
  local key = vim.api.nvim_replace_termcodes(rawkey, true, true, true)
  vim.api.nvim_feedkeys(key, 'n', false)
end

return M
