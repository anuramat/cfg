return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    start_in_insert = false,
    -- float_opts = {
    --   border = vim.g.border,
    -- },
  },
  highlights = {},
  -- keys = { { '<leader>t', '<cmd>ToggleTerm<cr>' } },
  keys = { { '<leader>t', '<cmd>ToggleTerm direction=float<cr>' } },
}
