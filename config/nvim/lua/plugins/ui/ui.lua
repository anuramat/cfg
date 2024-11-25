-- vim: fdl=1
return {
  -- rainbow-delimiters.nvim - TS rainbow parentheses
  {
    -- alterntaives:
    -- * https://github.com/luochen1990/rainbow -- 1.7k stars
    -- * https://github.com/junegunn/rainbow_parentheses.vim -- junegunn, seems "complete", 374 stars
    'HiPhish/rainbow-delimiters.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'BufEnter',
  },
  -- dressing.nvim - input/select ui elements
  {
    {
      'stevearc/dressing.nvim',
      opts = {
        input = {
          insert_only = true,
          border = vim.g.border,
        },
        select = {
          backend = { 'builtin', 'nui' },
          nui = { border = { style = vim.g.border } },
          builtin = { border = vim.g.border },
        },
      },
      event = 'VeryLazy',
    },
  },
  -- nvim-colorizer.lua - highlights colors, eg #012345
  {
    'NvChad/nvim-colorizer.lua',
    event = 'VeryLazy',
    opts = {},
  },
  -- vim-illuminate - highlights the word under cursor using LSP/TS/regex
  {
    'RRethy/vim-illuminate',
    event = 'VeryLazy',
    config = function()
      require('illuminate').configure({ filetypes_denylist = vim.g.nonfiles })
    end,
  },
  -- neopywal.nvim
  {
    'RedsXDD/neopywal.nvim',
    name = 'neopywal',
    lazy = false,
    priority = 1000,
    opts = {
      use_wallust = true,
      notify = true,
      transparent_background = true,
    },
  },
  -- todo-comments.nvim - highlights "todo", "hack", etc
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    opts = {
      sign_priority = -1000,
      highlight = {
        keyword = 'bg', -- only highlight the word
        pattern = [[<(KEYWORDS)>]], -- vim regex
        multiline = false, -- enable multine todo comments
      },
      search = {
        pattern = [[\b(KEYWORDS)\b]], -- ripgrep regex
      },
    },
  },
  -- indent-blankline.nvim
  {
    'lukas-reineke/indent-blankline.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'VeryLazy',
    main = 'ibl',
    init = function()
      vim.cmd([[se lcs+=lead:\ ]])
    end,
    opts = function()
      return {
        scope = { show_start = false },
        exclude = {
          filetypes = {
            'lazy',
          },
        },
      }
    end,
  },
}
