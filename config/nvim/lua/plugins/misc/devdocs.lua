return {
  -- enabled = false,
  'luckasRanarison/nvim-devdocs',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    ensure_installed = { 'bash', 'go', 'markdown', 'latex' },
  },
}
