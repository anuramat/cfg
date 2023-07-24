local group = vim.api.nvim_create_augroup("LSP: Autoformat On Write", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  callback = function()
    local client = vim.lsp.get_active_clients()[1]
    if client and client.server_capabilities.documentFormattingProvider then
      vim.lsp.buf.format({ async = false })
      return
    else
    end
  end,
})
