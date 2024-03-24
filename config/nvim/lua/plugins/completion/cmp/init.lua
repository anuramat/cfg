return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    'onsails/lspkind.nvim', -- icons

    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-emoji',
  },
  config = function()
    require('plugins.completion.cmp.insert')()
    require('plugins.completion.cmp.cmdline')()
  end,
}
