local specs = {}
local u = require('utils')

-- Highlights and searches comment tags like XXX
specs.todo = {
  'folke/todo-comments.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  opts = {
    sign_priority = -1000,
    highlight = {
      keyword = 'bg',
      pattern = [[<(KEYWORDS)>]], -- vim regex
    },
    search = {
      pattern = [[\b(KEYWORDS)\b]], -- ripgrep regex
    },
  },
}

-- Splits/joins code blocks based on Treesitter
specs.treesj = {
  'Wansmer/treesj',
  opts = {
    use_default_keymaps = false,
    max_join_length = 500,
  },
  keys = {
    {
      '<leader>j',
      function()
        require('treesj').toggle()
      end,
      desc = 'Split/Join TS node',
    },
  },
}

-- -- Splits/joins code blocks based on special per-language rules
-- specs.splitjoin = {
--   'AndrewRadev/splitjoin.vim',
--   lazy = false,
--   config = function()
--     vim.g.splitjoin_split_mapping = '<leader>J'
--     vim.g.splitjoin_join_mapping = '<leader>j'
--   end,
-- }

return u.values(specs)
