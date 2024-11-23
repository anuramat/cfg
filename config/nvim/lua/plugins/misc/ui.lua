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
  -- mini.trailspace - highlight and delete trailing whitespace
  {
    'echasnovski/mini.trailspace',
    event = 'VeryLazy',

    config = function()
      vim.api.nvim_create_user_command('Trim', require('mini.trailspace').trim, {})
    end,
  },
}
