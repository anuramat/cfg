local m = require("config.macros")
vim.g.mapleader = " "
local function map(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc, silent = true })
end
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Built-in ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { desc = "Exit from terminal insert mode" })

map("<Leader>bn", ":bn<CR>", "Keys: Next Buffer")
map("<Leader>bp", ":bp<CR>", "Keys: Buffer")
map("<Leader>bd", ":bd<CR>", "Keys: Buffer")
map("<Leader>bD", ":bd!<CR>", "Keys: Delete Buffer (forced)")

map("<Leader>qc", ":ccl<CR>", "Keys: Close Quickfix")

map("<C-u>", "<C-u>zz", "Keys: Scroll up")
map("<C-d>", "<C-d>zz", "Keys: Scroll down")
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Homegrown ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
map("<leader>#", m.CreateCommentHeader, "Keys: Create comment header")
