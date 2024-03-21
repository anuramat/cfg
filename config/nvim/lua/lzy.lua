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

require('lazy').setup({
  { import = 'plugins.specific' },
  { import = 'plugins.ui' },
  { import = 'plugins.misc' },
  { import = 'plugins.interface' },
  { import = 'plugins.extensions' },
  { import = 'plugins.agnostic' },
}, {
  change_detection = {
    enabled = false,
  },
  defaults = {
    lazy = true,
    cond = not vim.g.vscode,
  },
  ui = {
    border = vim.g.border,
  },
})
