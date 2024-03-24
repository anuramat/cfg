return {
  'RRethy/vim-illuminate',
  event = 'VeryLazy',
  config = function()
    require('illuminate').configure({
      filetypes_denylist = { -- TODO make a vim.g.nonfiles
        'NeogitStatus',
        'oil',
        'lazy',
        'lspinfo',
        'null-ls-info',
      },
    })
  end,
}
