local b = require('bindables')
local s = vim.keymap.set
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ The leader himself ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
vim.g.mapleader = ' '
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Helpers ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
local de = function(d) return "User: " .. d end
local n = function(l, r, d) s('n', l, r, { silent = true, desc = de(d) }) end
local v = function(l, r, d) s('v', l, r, { silent = true, desc = de(d) }) end
local i = function(l, r, d) s('i', l, r, { silent = true, desc = de(d) }) end
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Mappings ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
s({ 'n', 'v' }, '<space>', '<nop>', { silent = true, desc = de("NOP") })
s('t', '<esc>', '<c-\\><c-n>', { silent = true, desc = de("Leave Terminal Mode") })
-- Buffer
n('<leader>bn', ':bn<cr>', 'Next Buffer')
n('<leader>bp', ':bp<cr>', 'Previous Buffer')
n('<leader>bd', ':bd<cr>', 'Delete Buffer')
n('<leader>bD', ':bd!<cr>', 'Delete Buffer (forced)')
-- Quickfix
n('<leader>qc', ':ccl<cr>', 'Close Quickfix Item')
n('<leader>qo', ':cope<cr>', 'Open Quickfix Item')
n('<leader>qp', ':cn<cr>', 'Prev Quickfix Item')
n('<leader>qn', ':cp<cr>', 'Next Quickfix Item')
n('<leader>qf', ':cnew<cr>', 'Prev Quickfix List')
n('<leader>qb', ':col<cr>', 'Next Quickfix List')
n('<leader>qh', ':chi<cr>', 'Show Quickfix Lists')
-- Scroll with centered cursor
n('<c-u>', '<c-u>zz0', 'Half Page Up (centered)')
n('<c-d>', '<c-d>zz0', 'Half Page Down (centered)')
n('<c-b>', '<c-b>zz0', 'Page Up (centered)')
n('<c-f>', '<c-f>zz0', 'Page Down (centered)')
-- More reachable home/end
n('H', '^', 'Go to first non-blank character')
n('L', '$', 'Go to last character')
-- Move lines (I still don't get why it's -2)
n('<a-j>', '<cmd>m .+1<cr>==', 'Move Line Down')
n('<a-k>', '<cmd>m .-2<cr>==', 'Move Line Up')
v('<a-j>', ":m '>+1<cr>gv=gv", 'Move Lines Down')
v('<a-k>', ":m '<-2<cr>gv=gv", 'Move Lines Up')
i('<a-j>', '<esc><cmd>m .+1<cr>==gi', 'Move Line Down')
i('<a-k>', '<esc><cmd>m .-2<cr>==gi', 'Move Line Up')
-- Header
local header = function() b.create_comment_header('~') end
n('<leader>#', header, 'Create Comment Header')
local halfheader = function() b.create_comment_header('~', 0.5) end
n('<leader>$', halfheader, 'Create Comment Header')
