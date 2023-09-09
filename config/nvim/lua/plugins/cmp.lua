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
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ insert mode setup ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    -- ~~~~~~~~~~~~~~~~~~~~~~ keys ~~~~~~~~~~~~~~~~~~~~~~ --
    local luasnip = require('luasnip')
    local insert_keys = {
      ['<tab>'] = cmp.mapping(function(fallback)
        if luasnip.locally_jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<s-tab>'] = cmp.mapping(function(fallback)
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }
    -- ~~~~~~~~~~~~~~~~~~~~~ setup ~~~~~~~~~~~~~~~~~~~~~~ --
    cmp.setup({
      mapping = cmp.mapping.preset.insert(insert_keys),
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
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ cmdline setup ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    -- ~~~~~~~~~~~~~~~~~~~~~~ keys ~~~~~~~~~~~~~~~~~~~~~~ --
    -- BUG: for some reason mappings need to be wrapped in cmp.mapping explicitly for cmdline:
    -- [key] = cmp.mapping({ c = function })
    local cmdline_interrupters = { '<c-f>', '<c-d>' }
    local cmdline_keys = {
      ['<c-n>'] = cmp.mapping({ c = cmp.config.disable }),
      ['<c-p>'] = cmp.mapping({ c = cmp.config.disable }),
    }
    for _, hotkey in pairs(cmdline_interrupters) do -- this fixes BUG: cmp menu gets stuck on c_^f
      cmdline_keys[hotkey] = cmp.mapping({
        c = function(fallback)
          if cmp.visible() then
            cmp.abort()
          end
          fallback()
        end,
      })
    end
    -- ~~~~~~~~~~~~~~~~~~~~~ setup ~~~~~~~~~~~~~~~~~~~~~~ --
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(cmdline_keys),
      sources = cmp.config.sources(
        { { name = 'path', option = { trailing_slash = true } } },
        { { name = 'cmdline', option = { ignore_cmds = { 'Man', '!' } } } }
      ),
    })
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ search ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
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
