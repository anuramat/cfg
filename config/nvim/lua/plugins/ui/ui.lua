return {
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
}
