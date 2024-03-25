return {
  {
    'lervag/vimtex',
    lazy = false, -- author swears it's lazy inside
    init = function()
      vim.cmd([[
      let g:vimtex_view_method = 'zathura'
      " let maplocalleader = ","
    ]])
    end,
  },
}
