return {
  'lervag/vimtex',
  init = function()
    vim.cmd([[
      let g:vimtex_view_method = 'zathura'
      " let maplocalleader = ","
    ]])
  end,
}
