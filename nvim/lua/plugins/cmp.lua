local specs = {}

local u = require('utils')
local k = require('config.keys')

specs.cmp = {
  "hrsh7th/nvim-cmp",
  version = false,
  dependencies = {
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ insert mode ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    cmp.setup({
      mapping = cmp.mapping.preset.insert(k.cmp.i()),
      snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end, },
      sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'luasnip' } }, { { name = 'buffer' } }),
      window = { documentation = cmp.config.window.bordered() },
    })
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ cmdline ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(k.cmp.c()),
      sources = cmp.config.sources(
        { { name = 'path', option = { trailing_slash = true } } },
        { { name = 'cmdline', option = { ignore_cmds = { 'Man', '!' } } } }),
    })
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ search ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(k.cmp.c()),
      sources = { { name = 'buffer' } },
    })
  end,
}

specs.luasnip = {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  -- if build fails, install jsregexp luarock
  build = "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp",
}

return u.values(specs)
