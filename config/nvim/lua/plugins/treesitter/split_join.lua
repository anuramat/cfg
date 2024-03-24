-- Splits/joins code blocks based on Treesitter
return {
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
