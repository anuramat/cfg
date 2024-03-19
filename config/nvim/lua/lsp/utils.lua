local M = {}

local u = require('utils')
local af_group = vim.api.nvim_create_augroup('LSPAutoformatting', { clear = true })

local on_cmd = 'AutoformatOn'
local off_cmd = 'AutoformatOff'
local toggle_cmd = 'AutoformatToggle'

--- Format while skipping languages from _G.fmt_blacklist
--- Replaces opts.filter
--- @param opts table | nil mirrors that of vim.lsp.buf.format
local function format(opts)
  if opts == nil then
    opts = {}
  end
  opts.filter = function(client)
    return not u.contains(_G.fmt_srv_blacklist, client.name)
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
local function setup_lsp_autoformatting(client, buffer)
  if
    not client.server_capabilities.documentFormattingProvider
    or u.contains(_G.fmt_ft_blacklist, vim.api.nvim_buf_get_option(buffer, 'filetype'))
  then
    return
  end
  local clean = cleaner(buffer)
  clean() -- make sure we only use one formatter
  -- enable autoformatting
  enabler(buffer, function()
    format({ bufnr = buffer, async = false })
  end)()
  -- clean on detach
  vim.api.nvim_create_autocmd('LspDetach', {
    group = af_group,
    buffer = buffer,
    callback = clean,
  })
end

local function setup_lsp_keybinds(buffer)
  local function set(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = buffer, desc = 'LSP: ' .. desc })
  end
  local function set_prefixed(keys, func, desc)
    vim.keymap.set('n', '<leader>l' .. keys, func, { buffer = buffer, desc = 'LSP: ' .. desc })
  end

  local function list_workspace_folders()
    vim.print(vim.lsp.buf.list_workspace_folders())
  end

  local function references()
    vim.lsp.buf.references({ includeDeclaration = false })
  end

  vim.bo[buffer].omnifunc = 'v:lua.vim.lsp.omnifunc'

  set_prefixed('r', vim.lsp.buf.rename, 'Rename symbol')
  set_prefixed('f', format, 'Format buffer')
  set_prefixed('a', vim.lsp.buf.code_action, 'Code action')
  set_prefixed('l', vim.lsp.codelens.run, 'CodeLens')

  set('K', vim.lsp.buf.hover, 'Hover Documentation')
  set('gd', vim.lsp.buf.definition, 'Goto Definition') -- prototype: goto local declaration

  set('gD', vim.lsp.buf.declaration, 'Goto Declaration') -- prototype: goto global declaration
  set('gi', vim.lsp.buf.implementation, 'Goto Implementation') -- shadows: insert mode in the last insert mode position
  set('go', vim.lsp.buf.type_definition, 'Goto Type Definition') -- shadows: go to nth byte
  set('gr', references, 'Quickfix References') -- shadows: virtual replace single char
  set('gs', vim.lsp.buf.signature_help, 'Signature Help') -- shadows: sleep
  set('gl', vim.diagnostic.open_float, 'Show Diagnostic') -- new
  set('[d', vim.diagnostic.goto_prev, 'Previous Diagnostic') -- shadows: goto first macro definition
  set(']d', vim.diagnostic.goto_next, 'Next Diagnostic') -- shadows: goto next macro definition

  set_prefixed('q', vim.diagnostic.setloclist, 'Diagnostic Loc List')
  set_prefixed('Q', vim.diagnostic.setqflist, 'Diagnostic Loc List')

  set_prefixed('wa', vim.lsp.buf.add_workspace_folder, 'Add Workspace Folder')
  set_prefixed('wr', vim.lsp.buf.remove_workspace_folder, 'Remove Workspace Folder')
  set_prefixed('wl', list_workspace_folders, 'List Workspace Folders')
end

-- TODO docstring
--- creates autoformat autocommand, toggling commands
function M.default_on_attach(client, buffer)
  setup_lsp_keybinds(buffer)
  setup_lsp_autoformatting(client, buffer)
end

return M
