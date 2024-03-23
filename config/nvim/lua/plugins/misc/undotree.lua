-- undotree :)
return {
  'mbbill/undotree',
  cmd = {
    'UndotreeHide',
    'UndotreeShow',
    'UndotreeFocus',
    'UndotreeToggle',
  },
  keys = {
    {
      '<leader>u',
      '<cmd>UndotreeToggle<cr>',
      desc = 'Undotree',
    },
  },
}
