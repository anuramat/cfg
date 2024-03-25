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
  {
    'jbyuki/nabla.nvim',
    ft = { 'latex', 'markdown' },
    init = function() -- not sure if this will even work
      vim.cmd([[
        nnoremap <leader>p :lua require("nabla").popup()<CR> " Customize with popup({border = ...})  : `single` (default), `double`, `rounded`
      ]])
    end,
  },
}
