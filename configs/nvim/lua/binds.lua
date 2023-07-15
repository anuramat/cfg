vim.g.mapleader = " "
local c = require("custom")
local u = require("utils")
---------------------------------- Homegrown ----------------------------------
-- set('n', '<leader>h', ':lua CreateCommentHeader()<CR>', {
--     noremap = true,
--     silent = true,
--     desc = "Create comment header",
-- })
-- stylua: ignore
u.map("<leader>h", c.CreateCommentHeader, "Create comment header")
---------------------------------- Built-in -----------------------------------
u.map("<Leader>n", ":bn<CR>", "Next buffer")
u.map("<Leader>p", ":bp<CR>", "Previous buffer")
u.map("<Leader>d", ":bd<CR>", "Delete buffer")
