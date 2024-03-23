return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    start_in_insert = false,
    float_opts = {
      --   border = 'solid',
      winblend = vim.o.winblend,
    },
  },
  -- highlights = {
  --   NormalFloat = {
  --     guibg = '#123456',
  --     guifg = '#000000',
  --   },
  -- },
  -- keys = { { '<leader>t', '<cmd>ToggleTerm<cr>' } },
  keys = { { '<leader>t', '<cmd>ToggleTerm direction=float<cr>' } },
}
