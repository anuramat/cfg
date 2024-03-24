return {
  'lukas-reineke/lsp-format.nvim',
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
