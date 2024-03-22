return {
  'lukas-reineke/indent-blankline.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'VeryLazy',
  main = 'ibl',
  init = function()
    vim.cmd([[se lcs+=lead:\ ]])
  end,
  opts = {
    exclude = {
      filetypes = {
        'lazy',
      },
    },
    indent = {
      -- char = '│',
      char = '┃',
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
    },
  },
}
