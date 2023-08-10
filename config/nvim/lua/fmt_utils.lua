M = {}

local u = require('utils')

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

local af_group = vim.api.nvim_create_augroup('LSPAutoformatting', { clear = true })
--- Sets up autoformatting and format commands for buffer if client is capable.
--- Meant to be called in an on_attach handler
--- @param client table
--- @param buffer integer
function M.setup_autoformat(client, buffer)
  -- XXX Will use first suitable lsp to do formatting
  -- To modify, add "filter" option to lsp.buf.format opts
  local format_cmd = 'Format'
  local noformat_cmd = 'Noformat'
  -- check if we can format at all
  if not client.server_capabilities.documentFormattingProvider then
    return
  end
  -- ~~~~~~~~~~~~~~~~~ On/off switches ~~~~~~~~~~~~~~~~~ --
  local function autoformat_on()
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = af_group,
      buffer = buffer,
      callback = function()
        M.format({ bufnr = buffer, async = false })
      end,
    })
  end
  local function autoformat_off()
    vim.api.nvim_clear_autocmds({ group = af_group, buffer = buffer })
  end
  local function cmds_on()
    vim.api.nvim_buf_create_user_command(buffer, format_cmd, autoformat_on, {})
    vim.api.nvim_buf_create_user_command(buffer, noformat_cmd, autoformat_off, {})
  end
  local function cmds_off()
    pcall(function()
      vim.api.nvim_buf_del_user_command(buffer, format_cmd)
    end)
    pcall(function()
      vim.api.nvim_buf_del_user_command(buffer, noformat_cmd)
    end)
  end
  local function cleanup()
    autoformat_off()
    cmds_off()
  end
  -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
  -- make sure we don't have get two autocmds
  cleanup()
  -- start autoformatting, set up commands
  cmds_on()
  autoformat_on()
  -- cleanup on detach
  vim.api.nvim_create_autocmd('LspDetach', {
    group = af_group,
    buffer = buffer,
    callback = cleanup,
  })
end

return M
