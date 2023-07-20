local m = require("config.macros")
local u = require("utils")
vim.g.mapleader = " "
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Built-in ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { desc = "Exit from terminal insert mode" })

u.map("<Leader>bn", ":bn<CR>", "Keys: Next Buffer")
u.map("<Leader>bp", ":bp<CR>", "Keys: Buffer")
u.map("<Leader>bd", ":bd<CR>", "Keys: Buffer")
u.map("<Leader>bD", ":bd!<CR>", "Keys: Delete Buffer (forced)")

u.map("<Leader>c", ":ccl<CR>", "Keys: Close Quickfix")

u.map("<C-u>", "<C-u>zz", "Keys: Scroll up")
u.map("<C-d>", "<C-d>zz", "Keys: Scroll down")
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Homegrown ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
u.map("<leader>#", m.CreateCommentHeader, "Keys: Create comment header")
