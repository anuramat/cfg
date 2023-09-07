local b = require('bindables')
local s = vim.keymap.set
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ The leader himself ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
vim.g.mapleader = ' '
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Helpers ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
local function norm(l, r, d)
  s('n', l, r, { silent = true, desc = d })
end
local function vis(l, r, d)
  s('v', l, r, { silent = true, desc = d })
end
local function ins(l, r, d)
  s('i', l, r, { silent = true, desc = d })
end
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Mappings ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
-- Basics
s('t', '<esc>', '<c-\\><c-n>', { silent = true, desc = 'Leave Terminal Mode' })
-- ~~~~~~~~~~~~~~~~~~~~~~ Buffer ~~~~~~~~~~~~~~~~~~~~~~~ --
-- Ignore
local function skip_qf(f)
  return function()
    f()
    if vim.bo.filetype == 'qf' then
      f()
    end
  end
end
norm('<leader>bn', skip_qf(vim.cmd.bn), 'Next Buffer')
norm('<leader>bp', skip_qf(vim.cmd.bp), 'Previous Buffer')
norm('<leader>bd', ':bd<cr>', 'Delete Buffer')
norm('<leader>bD', ':bd!<cr>', 'Delete Buffer (forced)')
norm('<leader>bo', ':silent %bd|e#|bd#<cr>', 'Close Other Buffers')
-- Move lines (I still don't get why it's -2)
norm('<a-j>', ':m .+1<cr>==', 'Move Line Down')
norm('<a-k>', ':m .-2<cr>==', 'Move Line Up')
vis('<a-j>', ':m \'>+1<cr>gv=gv', 'Move Lines Down')
vis('<a-k>', ':m \'<-2<cr>gv=gv', 'Move Lines Up')
ins('<a-j>', '<esc>:m .+1<cr>==gi', 'Move Line Down')
ins('<a-k>', '<esc>:m .-2<cr>==gi', 'Move Line Up')
-- Headers
norm('<leader>#', function()
  b.create_comment_header('~', nil, 120)
end, 'Create Comment Header')
norm('<leader>$', function()
  b.create_comment_header('~', nil, 60)
end, 'Create Comment Subheader')
-- TODO move some to vimscript so that vim can also use it?
