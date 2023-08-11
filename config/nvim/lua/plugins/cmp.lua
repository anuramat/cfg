local specs = {}
local k = require('plugkeys')
local u = require('utils')

specs.cmp = {
  'hrsh7th/nvim-cmp',
  version = false,
  dependencies = {
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
  },
  config = function()
    local cmp = require('cmp')
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ insert mode ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    cmp.setup({
      mapping = cmp.mapping.preset.insert(k.cmp.main()),
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources(
        { { name = 'nvim_lsp' }, { name = 'luasnip' } },
        { { name = 'path', option = { trailing_slash = true } } },
        { { name = 'buffer' } }
      ),
      window = { documentation = cmp.config.window.bordered() },
    })
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ cmdline ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(k.cmp.cmdline()),
      sources = cmp.config.sources(
        { { name = 'path', option = { trailing_slash = true } } },
        { { name = 'cmdline', option = { ignore_cmds = { 'Man', '!' } } } }
      ),
    })
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ search ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = 'buffer' } },
    })
  end,
}

specs.luasnip = {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'rafamadriz/friendly-snippets',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()

      local ls = require('luasnip')
      local i = ls.insert_node
      local s = ls.snippet
      local fmt = require('luasnip.extras.fmt').fmt
      ls.add_snippets('sh', {
        s(
          'chksrc',
          fmt(
            '{var}="{path}" && [ -r "${{{var}}}" ] && . "${{{var}}}" && unset {var}',
            { var = i(1, 'var'), path = i(0, 'path') },
            { repeat_duplicates = true }
          )
        ),
      })
    end,
  },
  -- if build fails, install jsregexp luarock
  build = 'echo \'NOTE: jsregexp is optional, so not a big deal if it fails to build\'; make install_jsregexp',
}

return u.values(specs)
