return {
  'dhruvasagar/vim-table-mode',
  config = function()
    vim.g.table_mode_disable_mappings = 1
    vim.cmd([[
      autocmd FileType markdown nnoremap <leader><leader> <cmd>TableModeRealign<cr>
    ]])
  end,
  ft = 'markdown',
}
