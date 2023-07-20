local specs = {}

local u = require("utils")

local cfgs = {}
local servers = { "bashls" }

cfgs.gopls = {
  settings = {
    gopls = {
      analyses = {
        fieldalignment = true,
        nilness = true,
        shadow = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
        unusedvariable = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}

cfgs.lua_ls = {
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

local zero_preset = {
  float_border = "rounded",
  call_servers = "global",
  configure_diagnostics = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = {
    preserve_mappings = false,
    omit = {},
  },
  manage_nvim_cmp = true
}


specs.lspzero = {
  "VonHeikemen/lsp-zero.nvim",
  event = { "VeryLazy", "BufReadPost", "BufNewFile" },
  dependencies = {
    { "folke/neodev.nvim", opts = {} },
    "neovim/nvim-lspconfig",

    "L3MON4D3/LuaSnip",

    "hrsh7th/cmp-buffer",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    {
      "hrsh7th/nvim-cmp",
      version = false,
      dependencies = { "hrsh7th/cmp-cmdline", "hrsh7th/cmp-path",
      },
      config = function()
        local cmp = require("cmp")
        cmp.setup({
          sources = {
            { name = 'nvim_lsp' }
          }
        })
        local capabilities = require('cmp_nvim_lsp').default_capabilities()


        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'path' }
          }, {
            {
              name = 'cmdline',
              option = {
                ignore_cmds = { 'Man', '!' }
              }
            }
          })
        })
      end,
    },
  },
  branch = "v2.x",
  opts = {},
  config = function()
    local lsp = require("lsp-zero").preset(zero_preset)
    lsp.on_attach(function(_, bufnr)
      lsp.default_keymaps({ buffer = bufnr })
      lsp.buffer_autoformat()
    end)
    local lspconfig = require("lspconfig")
    lspconfig.gopls.setup(cfgs.gopls)
    lspconfig.lua_ls.setup(lsp.nvim_lua_ls(cfgs.lua_ls))
    lsp.setup_servers(servers)

    lsp.skip_server_setup({ 'hls' })
    lsp.setup()
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

return u.respec(specs)
