local M = {}

local overrides = require('utils.lsp.format_overrides')
local u = require('utils')

local enable_cmd = 'FormatOn'
local disable_cmd = 'FormatOff'
local toggle_cmd = 'FormatToggle'
local format_cmd = 'Format'

local group_name = 'LSPAutoformat'
local event = 'BufWritePre'
local group = vim.api.nvim_create_augroup(group_name, { clear = true })

--- Format while skipping blacklisted servers
--- @param opts table | nil mirrors that of vim.lsp.buf.format
M.format = function(opts)
  if opts == nil then
    opts = {}
  end

  -- make a new filter for blacklisted servers
  local new_filter = function(client)
    return not u.contains(overrides.fmt_srv_blacklist, client.name)
  end
  -- get the old filter
  local old_filter = opts.filter
  if old_filter == nil then
    old_filter = function(_)
      return true
    end
  end
  -- merge filters
  opts.filter = function(client)
    return old_filter(client) and new_filter(client)
  end

  vim.lsp.buf.format(opts)
end

--- @param buffer integer
--- @return boolean
local function is_enabled(buffer)
  return #vim.api.nvim_get_autocmds({
    group = group_name,
    event = event,
    buffer = buffer,
  }) ~= 0
end

--- Enables autoformat
--- @param buffer integer
--- @return function enable
local function enabler(buffer)
  return function()
    if is_enabled(buffer) then
      vim.notify('autoformatting is already on')
      return
    end

    vim.api.nvim_create_autocmd('BufWritePre', {
      group = group,
      buffer = buffer,
      callback = function()
        M.format({ bufnr = buffer, async = false })
      end,
    })
  end
end

--- Disables autoformat
--- @param buffer integer
--- @return function disable
local function disabler(buffer)
  return function()
    if not is_enabled(buffer) then
      vim.notify('autoformatting is already off')
      return
    end
    vim.api.nvim_clear_autocmds({ group = group, event = event, buffer = buffer })
  end
end

--- Toggles autoformat
--- @param buffer integer
--- @return function toggle
local function toggler(buffer)
  return function()
    if is_enabled(buffer) then
      disabler(buffer)()
      return
    end
    enabler(buffer)()
  end
end

--- Nukes everything
local function cleaner(buffer)
  return function()
    -- remove all autocommands
    vim.api.nvim_clear_autocmds({ group = group, buffer = buffer })
    -- remove commands
    local function deregister(name)
      pcall(function()
        vim.api.nvim_buf_del_user_command(buffer, name)
      end)
    end
    deregister(disable_cmd)
    deregister(enable_cmd)
    deregister(toggle_cmd)
  end
end

--- Sets up autoformatting and format commands for buffer if client is capable.
--- Meant to be called in an on_attach handler
--- @param client table
--- @param buffer integer
M.setup_lsp_autoformatting = function(client, buffer)
  -- filter out blacklisted filetypes
  if
    not client.server_capabilities.documentFormattingProvider
    or u.contains(overrides.fmt_ft_blacklist, vim.api.nvim_buf_get_option(buffer, 'filetype'))
  then
    return
  end
  -- carefully enable af
  cleaner(buffer)()
  enabler(buffer)()
  -- set up commands
  vim.api.nvim_buf_create_user_command(buffer, toggle_cmd, toggler(buffer), {})
  vim.api.nvim_buf_create_user_command(buffer, enable_cmd, enabler(buffer), {})
  vim.api.nvim_buf_create_user_command(buffer, disable_cmd, disabler(buffer), {})
  -- add persistent `:Format`
  vim.api.nvim_buf_create_user_command(buffer, format_cmd, function()
    M.format({ bufnr = buffer, async = false })
  end, {})
  -- clean on detach
  vim.api.nvim_create_autocmd('LspDetach', {
    group = group,
    buffer = buffer,
    callback = cleaner(buffer),
  })
end

return M
