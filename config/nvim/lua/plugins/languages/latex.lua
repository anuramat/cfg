return {
  {
    'lervag/vimtex',
    lazy = false, -- author swears it's lazy inside
    init = function()
      vim.cmd([[
      let g:vimtex_view_method = 'zathura'
      let g:vimtex_mappings_prefix = '<leader>L'
    ]])
    end,
  },
}
