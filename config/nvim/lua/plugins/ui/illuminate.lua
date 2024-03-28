-- echasnovski/mini.cursorword
return {
  'RRethy/vim-illuminate',
  event = 'VeryLazy',
  config = function()
    require('illuminate').configure({
      filetypes_denylist = { -- TODO make a vim.g.nonfiles
        'NeogitStatus',
        'NeogitPopup',
        'oil',
        'lazy',
        'lspinfo',
        'null-ls-info',
        'NvimTree',
        'neo-tree',
        'alpha'
      },
    })
  end,
}
