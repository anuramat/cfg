local m = require("config.macros")
local u = require("utils")
vim.g.mapleader = " "
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Built-in ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
u.map("<Leader>n", ":bn<CR>", "Keys: Next Buffer")
u.map("<Leader>p", ":bp<CR>", "Keys: Buffer")
u.map("<Leader>d", ":bd<CR>", "Keys: Buffer")
u.map("<Leader>D", ":bd!<CR>", "Keys: Delete Buffer (forced)")

u.map("<Leader>c", ":ccl<CR>", "Keys: Close Quickfix")

u.map("<C-u>", "<C-u>zz", "Keys: Scroll up")
u.map("<C-d>", "<C-d>zz", "Keys: Scroll down")
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Homegrown ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
u.map("<leader>#", m.CreateCommentHeader, "Keys: Create comment header")
