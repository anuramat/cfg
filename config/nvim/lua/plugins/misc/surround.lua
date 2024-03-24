-- The most popular surround plugin (right after tpope/vim-surround)
return {
  'kylechui/nvim-surround',
  opts = {
    keymaps = {
      insert = false,
      insert_line = false,
      normal = '<leader>s',
      normal_cur = '<leader>ss',
      normal_line = '<leader>S',
      normal_cur_line = '<leader>SS',
      visual = '<leader>s',
      visual_line = '<leader>S',
      delete = 'ds',
      change = 'cs',
      change_line = 'cS',
    },
  },
  event = 'VeryLazy',
}
