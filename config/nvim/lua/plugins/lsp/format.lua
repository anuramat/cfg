return {
  'lukas-reineke/lsp-format.nvim',
  -- TODO use sync formatting
  opts = {
    lua = {
      exclude = {
        'lua_ls',
      },
    },
    nix = {
      exclude = {
        'nixd',
        'nil_ls',
      },
    },
  },
}
