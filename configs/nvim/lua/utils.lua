local utils = {}

function utils.is_blank(s)
  return s:match("^%s*$") ~= nil
end

function utils.print(name, value)
  vim.notify(string.format(name .. ": %s", value))
end

-- :help lua-options
function utils.reset(accessor, option)
  accessor[option] = vim.api.nvim_get_option_info2(option, {}).default
end

-- checks if first n lines contain a keyword
function utils.contains(buffer, keyword, n)
  local lines = vim.api.nvim_buf_get_lines(buffer, 0, n, false)
  for _, line in ipairs(lines) do
    if string.find(line, keyword) then
      return true
    end
  end
  return false
end

function utils.map(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end

-- returns lazy mapping
function utils.lazy_map(lhs, rhs, desc)
  return {
    lhs,
    rhs,
    noremap = true,
    silent = true,
    desc = desc,
  }
end

-- get indentation of the current line in spaces
function utils.get_indent()
  local line_i = vim.api.nvim_win_get_cursor(0)[1] -- Get the current line number
  local line = vim.api.nvim_buf_get_lines(0, line_i - 1, line_i, false)[1] -- Get the current line content
  local ts = vim.api.nvim_buf_get_option(0, "tabstop") -- Get the current tabstop value

  local spaces = line:match("^ *") or ""
  local tabs = line:match("^\t*") or ""

  local indent_level = #spaces + (#tabs * ts)
  return indent_level
end

function utils.trim(s)
  return s:gsub("^%s+", ""):gsub("%s+$", "")
end

----------------------------- stolen from LazyVim -----------------------------
function utils.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

function utils.on_load(name, fn)
  local Config = require("lazy.core.config")
  if Config.plugins[name] and Config.plugins[name]._.loaded then
    vim.schedule(function()
      fn(name)
    end)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

function utils.has(plugin)
  return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

function utils.on_very_lazy(fn)
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      fn()
    end,
  })
end

function utils.fg(name)
  ---@type {foreground?:number}?
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name }) or vim.api.nvim_get_hl_by_name(name, true)
  local fg = hl and hl.fg or hl.foreground
  return fg and { fg = string.format("#%06x", fg) }
end

return utils
