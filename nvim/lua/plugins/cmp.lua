local specs = {}

local u = require('utils')

local function next()
  local cmp = require('cmp')
  if cmp.visible() then
    cmp.select_next_item()
  else
    cmp.complete()
  end
end

local function prev()
  local cmp = require('cmp')
  if cmp.visible() then
    cmp.select_prev_item()
  else
    cmp.complete()
  end
end

local function enter()
  local cmp = require('cmp')
  if cmp.visible() then
    cmp.confirm({ select = true })
  else
    local key = vim.api.nvim_replace_termcodes("<CR>", true, true, true)
    vim.api.nvim_feedkeys(key, 'n', false)
  end
end

local function confirm()
  require('cmp').confirm({ select = false })
end

local function abort()
  require('cmp').abort()
end

local function d(text)
  return 'CMP: ' .. text
end


specs.cmp = {
  "hrsh7th/nvim-cmp",
  version = false,
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
  },
  keys = {
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ insert mode ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    { '<c-n>',   next,    mode = 'i',          desc = d('Next Entry') },
    { '<c-p>',   prev,    mode = 'i',          desc = d('Previous Entry') },
    { '<cr>',    enter,   mode = 'i',          desc = d('Select Current Entry') },
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ common ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    { '<tab>',   next,    mode = { 'i', 'c' }, desc = d('Next Entry') },
    { '<s-tab>', prev,    mode = { 'i', 'c' }, desc = d('Previous Entry') },
    { '<c-y>',   confirm, mode = { 'i', 'c' }, desc = d('Select Current Entry') },
    { '<c-e>',   abort,   mode = { 'i', 'c' }, desc = d('Abort Completion') },
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ cmdline ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    { '<c-z>',   next,    mode = 'c',          desc = d('Next Entry') },
  },
  config = function()
    local cmp = require("cmp")

    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ insert mode ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      performance = { max_view_entries = 20 },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
      }, {
        { name = 'buffer' },

      })
    })

    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ cmdline ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    cmp.setup.cmdline(':', {
      sources = cmp.config.sources(
        { { name = 'path', option = { trailing_slash = true } } },
        { { name = 'cmdline', option = { ignore_cmds = { 'Man', '!' } } } })
    })

    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ search ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    cmp.setup.cmdline({ '/', '?' }, {
      sources = { { name = 'buffer' } }
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

return u.respec(specs)
