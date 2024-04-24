return {
  'dhruvasagar/vim-table-mode',
  init = function()
    vim.g.table_mode_disable_mappings = 1
    vim.g.table_mode_disable_tableize_mappings = 1
    vim.keymap.set('n', '<leader>T', '<cmd>TableModeToggle<cr>', { silent = true, desc = 'Table Mode: Toggle' })
    vim.keymap.set('n', '<leader>t', '<cmd>TableModeRealign<cr>', { silent = true, desc = 'Table Mode: Realign once' })
  end,
  ft = 'markdown',
}
