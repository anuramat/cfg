local u = require('utils')
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
require('lazy').setup(u.make_imports('plugins'), {
  change_detection = {
    enabled = false,
  },
  defaults = {
    lazy = true,
    cond = not vim.g.vscode,
    version = '*', -- nil for latest, * for latest stable semver
  },
  ui = {
    border = vim.g.border,
  },
})
