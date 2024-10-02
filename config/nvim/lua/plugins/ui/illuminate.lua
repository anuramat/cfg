return {
  -- highlights the word under cursor
  'RRethy/vim-illuminate',
  -- alternatively, echasnovski/mini.cursorword
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
        'alpha',
        'help',
      },
    })
  end,
}
