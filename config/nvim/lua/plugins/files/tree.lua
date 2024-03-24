return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    event = 'VeryLazy',
  },
  {
    'nvim-tree/nvim-tree.lua',
    event = 'VeryLazy',
    init = function()
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      -- optionally enable 24-bit colour
      vim.opt.termguicolors = true
      -- empty setup using defaults
    end,
    opts = {},
  },
}
