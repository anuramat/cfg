local u = require("utils")

local group = vim.api.nvim_create_augroup(u.username .. ".misc", { clear = true })

-- Go indentation
vim.api.nvim_create_autocmd("Filetype", {
  group = group,
  pattern = { "go" },
  command = "setlocal noexpandtab",
})
