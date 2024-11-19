return {
  {
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup({
        disable_defaults = true,
        lsp_keymaps = false,
        dap_debug_keymap = false,
      })
    end,
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    'leoluz/nvim-dap-go',
    ft = 'go',
    opts = {},
  },
}
