return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      {
        's1n7ax/nvim-window-picker',
        opts = {
          hint = 'floating-big-letter',
        },
      },
    },
    event = 'VeryLazy',
    config = function() end,
  },
  -- {
  --   'nvim-tree/nvim-tree.lua',
  --   event = 'VeryLazy',
  --   opts = {},
  -- },
}
