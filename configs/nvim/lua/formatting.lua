local utils = require("utils")
local prefix = "anuramat"
local group = vim.api.nvim_create_augroup(prefix .. "formatting", { clear = true })
---------------------------------- Settings -----------------------------------
local formatters = {
  -- sh = "shfmt",
}
--------------------------- Forced tabs for golang ----------------------------
vim.api.nvim_create_autocmd("Filetype", {
  group = group,
  pattern = { "go" },
  command = "setlocal noexpandtab",
})
--------------------------------- Formatting ----------------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local buffer = vim.api.nvim_get_current_buf()
    local noformat = utils.contains(buffer, "noformat", 3)
    if noformat then
      return
    end

    local filetype = vim.bo.filetype
    if formatters[filetype] ~= nil then
      vim.cmd("silent %!" .. formatters[filetype])
      return
    end

    local client = vim.lsp.get_active_clients()[1]
    if client and client.server_capabilities.documentFormattingProvider then
      vim.lsp.buf.format({ async = false })
      return
    else
    end
  end,
})
