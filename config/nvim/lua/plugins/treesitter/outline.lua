-- symbol outline
-- simrat39/symbols-outline.nvim
return {
  'stevearc/aerial.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  event = 'BufEnter',
  opts = {
    filter_kind = {
      nix = false,
    },
  },
  keys = { { 'gO', '<cmd>AerialToggle!<cr>', desc = 'Show Aerial Outline' } },
}
