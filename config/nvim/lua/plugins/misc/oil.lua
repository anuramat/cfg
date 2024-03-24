-- File manager
return {
  'stevearc/oil.nvim',
  -- event = 'VeryLazy',
  lazy = false, -- so that it overrides "nvim <path>"
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>o', '<cmd>Oil<cr>', desc = 'File Manager (Oil)' },
  },
}
