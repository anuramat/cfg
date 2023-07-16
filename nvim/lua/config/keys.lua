local m = require("config.macros")
local u = require("config.utils")
vim.g.mapleader = " "
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Built-in ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
u.map("<Leader>n", ":bn<CR>", "Next buffer")
u.map("<Leader>p", ":bp<CR>", "Previous buffer")
u.map("<Leader>d", ":bd<CR>", "Delete buffer")
u.map("<Leader>D", ":bd!<CR>", "Delete buffer (forced)")

u.map("<C-u>", "<C-u>zz", "Scroll up")
u.map("<C-d>", "<C-d>zz", "Scroll down")
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Homegrown ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
u.map("<leader>h", m.CreateCommentHeader, "Create comment header")
