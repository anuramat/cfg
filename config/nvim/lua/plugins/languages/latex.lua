local function setup_commands()
  local sync = 'VimtexSync'
  local desync = 'VimtexDesync'

  local grname = 'VimtexSyncGroup'
  vim.api.nvim_create_user_command(sync, function()
    local group = vim.api.nvim_create_augroup(grname, {})
    vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
      group = group,
      buffer = 0,
      callback = function()
        vim.cmd('VimtexView')
      end,
    })
  end, {})
  vim.api.nvim_create_user_command(desync, function()
    pcall(vim.api.nvim_del_augroup_by_name, grname)
  end, {})
end

return {
  {
    'lervag/vimtex',
    lazy = false, -- author swears it's lazy inside
    init = function()
      vim.cmd([[
      let g:vimtex_view_method = 'zathura'
      let g:vimtex_mappings_prefix = '<localleader>'
      let g:tex_flavor='latex'
      let g:tex_conceal='abdmg'
      let g:vimtex_quickfix_mode=0 " do not open qf automatically
      let g:vimtex_syntax_conceal = {
            \ 'accents': 1,
            \ 'ligatures': 1,
            \ 'cites': 1,
            \ 'fancy': 1,
            \ 'spacing': 1,
            \ 'greek': 1,
            \ 'math_bounds': 1,
            \ 'math_delimiters': 1,
            \ 'math_fracs': 1,
            \ 'math_super_sub': 1,
            \ 'math_symbols': 1,
            \ 'sections': 0,
            \ 'styles': 1,
            \}
      " let g:vimtex_syntax_conceal=
      " g:vimtex_syntax_conceal_disable
      """ a = accents/ligatures
      """ b = bold and italic
      """ d = delimiters
      """ m = math symbols
      """ g = Greek
      """ s = superscripts/subscripts
    ]])
    end,
    config = setup_commands(),
  },
  -- {
  --   'bytesnake/vim-graphical-preview',
  --   lazy = false,
  --   build = 'cargo build --release',
  --   dependencies = {
  --     { 'mattn/libcallex-vim', lazy = false, build = 'make -C autoload' }, -- nix-shell -p libffi
  --   },
  -- },
}
