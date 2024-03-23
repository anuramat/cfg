-- Align text interactively
-- See also:
-- junegunn/vim-easy-align
-- godlygeek/tabular
-- tommcdo/vim-lion
-- Vonr/align.nvim
return {
  'echasnovski/mini.align',
  opts = {
    mappings = {
      start = '<leader>a',
      start_with_preview = '<leader>A',
    },
  },
  keys = {
    { mode = { 'x', 'n' }, '<leader>a', desc = 'Align' },
    { mode = { 'x', 'n' }, '<leader>A', desc = 'Interactive align' },
  },
}
