local M = {}

local u = require('utils')
local af_group = vim.api.nvim_create_augroup('LSPAutoformatting', { clear = true })

local format_cmd = 'Format'
local noformat_cmd = 'Noformat'

--- Format while skipping languages from _G.fmt_blacklist
--- Replaces opts.filter
--- @param opts table | nil mirrors that of vim.lsp.buf.format
function M.format(opts)
  if opts == nil then
    opts = {}
  end
  opts.filter = function(client)
    return not u.contains(_G.fmt_blacklist, client.name)
  end
  vim.lsp.buf.format(opts)
end

local function af_on(buffer, callback)
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = af_group,
    buffer = buffer,
    callback = callback,
  })
end
local function af_off(buffer)
  vim.api.nvim_clear_autocmds({ group = af_group, buffer = buffer })
end
local function cmds_on(buffer, callback)
  local af_on_wrapped = function()
    af_on(0, callback)
  end
  vim.api.nvim_buf_create_user_command(buffer, format_cmd, af_on_wrapped, {})
  vim.api.nvim_buf_create_user_command(buffer, noformat_cmd, af_off, {})
end
local function cmds_off(buffer)
  pcall(function()
    vim.api.nvim_buf_del_user_command(buffer, format_cmd)
  end)
  pcall(function()
    vim.api.nvim_buf_del_user_command(buffer, noformat_cmd)
  end)
end
local function get_cleaner(buffer)
  return function()
    af_off(buffer)
    cmds_off(buffer)
  end
end

--- Sets up autoformatting and format commands for buffer if client is capable.
--- Meant to be called in an on_attach handler
--- @param client table
--- @param buffer integer
function M.setup_lsp_af(client, buffer)
  if not client.server_capabilities.documentFormattingProvider then
    return
  end
  local clean = get_cleaner(buffer)
  clean()
  cmds_on(buffer)

  af_on(buffer, function()
    M.format({ bufnr = buffer, async = false })
  end)
  vim.api.nvim_create_autocmd('LspDetach', {
    group = af_group,
    buffer = buffer,
    callback = clean,
  })
end

return M
