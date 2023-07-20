local m = {}

m.username = "anuramat"

function m.is_blank(s)
  return s:match("^%s*$") ~= nil
end

function m.print(name, value)
  vim.notify(string.format(name .. ": %s", value))
end

-- :help lua-options
function m.reset(accessor, option)
  accessor[option] = vim.api.nvim_get_option_info2(option, {}).default
end

-- checks if first n lines contain a keyword
function m.contains(buffer, keyword, n)
  local lines = vim.api.nvim_buf_get_lines(buffer, 0, n, false)
  for _, line in ipairs(lines) do
    if string.find(line, keyword) then
      return true
    end
  end
  return false
end

-- returns lazy mapping
function m.lazy_map(lhs, rhs, desc)
  return {
    lhs,
    rhs,
    noremap = true,
    silent = true,
    desc = desc,
  }
end

-- get indentation of the current line in spaces
function m.get_indent()
  local line_i = vim.api.nvim_win_get_cursor(0)[1]                         -- Get the current line number
  local line = vim.api.nvim_buf_get_lines(0, line_i - 1, line_i, false)[1] -- Get the current line content
  local ts = vim.api.nvim_buf_get_option(0, "tabstop")                     -- Get the current tabstop value

  local spaces = line:match("^ *") or ""
  local tabs = line:match("^\t*") or ""

  local indent_level = #spaces + (#tabs * ts)
  return indent_level
end

function m.trim(s)
  return s:gsub("^%s+", ""):gsub("%s+$", "")
end

function m.respec(specs)
  local result = {}
  for _, value in pairs(specs) do
    table.insert(result, value)
  end
  return result
end

return m
