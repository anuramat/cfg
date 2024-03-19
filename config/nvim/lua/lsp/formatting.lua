local M = {}

local overrides = require('lsp.language_specific.format_overrides')
local u = require('utils')

local af_group = vim.api.nvim_create_augroup('LSPAutoformatting', { clear = true })
local on_cmd = 'AutoformatOn'
local off_cmd = 'AutoformatOff'
local toggle_cmd = 'AutoformatToggle'

--- Format while skipping languages from _G.fmt_blacklist
--- Replaces opts.filter
--- @param opts table | nil mirrors that of vim.lsp.buf.format
M.format = function(opts)
  if opts == nil then
    opts = {}
  end
  opts.filter = function(client)
    return not u.contains(overrides.fmt_srv_blacklist, client.name)
  end
  vim.lsp.buf.format(opts)
end
local disabler
--- returns a function that sets up autoformat
local function enabler(buffer, callback)
  return function()
    -- enable af
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = af_group,
      buffer = buffer,
      callback = callback,
    })
    -- add disable cmd
    local disable = disabler(buffer, callback)
    vim.api.nvim_buf_create_user_command(buffer, off_cmd, disable, {})
    vim.api.nvim_buf_create_user_command(buffer, toggle_cmd, disable, {})
  end
end
--- returns a function that turns off autoformat
disabler = function(buffer, callback)
  return function()
    -- disable af
    vim.api.nvim_clear_autocmds({ group = af_group, buffer = buffer })
    -- add enable cmd
    local enable = enabler(buffer, callback)
    vim.api.nvim_buf_create_user_command(buffer, on_cmd, enable, {})
    vim.api.nvim_buf_create_user_command(buffer, toggle_cmd, enable, {})
  end
end

--- nukes everything
local function cleaner(buffer)
  return function()
    -- disable af
    disabler(buffer, function() end)()
    -- remove cmds
    local function deregister(name)
      pcall(function()
        vim.api.nvim_buf_del_user_command(buffer, name)
      end)
    end
    deregister(off_cmd)
    deregister(on_cmd)
    deregister(toggle_cmd)
  end
end

--- Sets up autoformatting and format commands for buffer if client is capable.
--- Meant to be called in an on_attach handler
--- @param client table
--- @param buffer integer
M.setup_lsp_autoformatting = function(client, buffer)
  if
    not client.server_capabilities.documentFormattingProvider
    or u.contains(overrides.fmt_ft_blacklist, vim.api.nvim_buf_get_option(buffer, 'filetype'))
  then
    return
  end
  local clean = cleaner(buffer)
  clean() -- make sure we only use one formatter
  -- enable autoformatting
  enabler(buffer, function()
    M.format({ bufnr = buffer, async = false })
  end)()
  -- clean on detach
  vim.api.nvim_create_autocmd('LspDetach', {
    group = af_group,
    buffer = buffer,
    callback = clean,
  })
end

return M
