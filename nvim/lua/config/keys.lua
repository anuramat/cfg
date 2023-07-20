local m = require("config.macros")
vim.g.mapleader = " "
local function nmap(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc, silent = true })
end
local function vmap(lhs, rhs, desc)
  vim.keymap.set("v", lhs, rhs, { desc = desc, silent = true })
end
local function imap(lhs, rhs, desc)
  vim.keymap.set("i", lhs, rhs, { desc = desc, silent = true })
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Built-in ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { desc = "Exit from terminal insert mode" })

nmap("<leader>bn", ":bn<cr>", "Keys: Next Buffer")
nmap("<leader>bp", ":bp<cr>", "Keys: Buffer")
nmap("<leader>bd", ":bd<cr>", "Keys: Buffer")
nmap("<leader>bD", ":bd!<cr>", "Keys: Delete Buffer (forced)")

nmap("<leader>qc", ":ccl<cr>", "Keys: Close Quickfix")

nmap("<c-u>", "<c-u>zz", "Keys: Scroll up")
nmap("<c-d>", "<c-d>zz", "Keys: Scroll down")


nmap("<a-j>", "<cmd>m .+1<cr>==", { desc = "Keys: Move line down" })
nmap("<a-k>", "<cmd>m .-2<cr>==", { desc = "Keys: Move line up" })
imap("<a-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Keys: Move line down" })
imap("<a-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Keys: Move line up" })
vmap("<a-j>", ":m '>+1<cr>gv=gv", { desc = "Keys: Move line down" })
vmap("<a-k>", ":m '<-2<cr>gv=gv", { desc = "Keys: Move line up" })
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Homegrown ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
nmap("<leader>#", m.CreateCommentHeader, "Keys: Create comment header")
