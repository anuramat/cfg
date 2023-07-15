local u = require("config.utils")
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
local prefix = "anuramat"
local group = vim.api.nvim_create_augroup(prefix .. "formatting", { clear = true })
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~ External formatters ~~~~~~~~~~~~~~~~~~~~~~~~~~ --
local formatters = {
  -- filetype = "formatter_binary",
}
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Go indentation ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
vim.api.nvim_create_autocmd("Filetype", {
  group = group,
  pattern = { "go" },
  command = "setlocal noexpandtab",
})
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = group,
--   callback = function(args)
--     local noformat = u.contains(args.buf, "noformat", 3)
--     if noformat then
--       return
--     end
--
--     local filetype = vim.bo.filetype
--     if formatters[filetype] ~= nil then
--       vim.cmd("silent %!" .. formatters[filetype])
--       return
--     end
--
--     local client = vim.lsp.get_active_clients()[1]
--     if client and client.server_capabilities.documentFormattingProvider then
--       vim.lsp.buf.format({ async = false })
--       return
--     else
--     end
--   end,
-- })
