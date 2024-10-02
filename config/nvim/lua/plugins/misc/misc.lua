-- vim: fdl=1

return {
  -- sleuth - autodetects indentation settings
  {
    'tpope/vim-sleuth',
    lazy = false,
  },
  -- colorizer - highlights eg #012345
  {
    'NvChad/nvim-colorizer.lua',
    event = 'VeryLazy',
    opts = {},
  },
  -- bracketed - new ]/[ targets
  {
    'echasnovski/mini.bracketed',
    lazy = false,
    opts = {},
  },
  -- sniprun - run selected code
  {
    event = 'VeryLazy',
    'michaelb/sniprun',
    branch = 'master',
    build = 'sh install.sh',
    opts = {},
  },
  -- gnu info browser
  {
    'HiPhish/info.vim',
    event = 'VeryLazy',
  },
  -- flash
  {
    'folke/flash.nvim',
    opts = {
      modes = {
        search = { enabled = false },
        char = { enabled = false },
      },
    },
    keys = {
      {
        's',
        mode = 'n',
        function()
          require('flash').jump()
        end,
        desc = 'Jump',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').treesitter()
        end,
        desc = 'TS node',
      },
    },
  },
}
