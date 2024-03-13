local specs = {}
local u = require('utils')

--- Jump to a snippet field
--- Fallback is called if jump isn't possible
--- @param jump_size integer Relative position of the target field
--- @return function mapping
local function wrap_snippet_jump(jump_size)
  local luasnip = require('luasnip')
  return function(fallback)
    if luasnip.locally_jumpable(jump_size) then
      luasnip.jump(jump_size)
    else
      fallback()
    end
  end
end

specs.cmp = {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'L3MON4D3/LuaSnip', -- TODO use vsnip? brand loyalty xd
    'saadparwaiz1/cmp_luasnip',

    'onsails/lspkind.nvim', -- icons

    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-emoji',
  },
  config = function()
    local cmp = require('cmp')
    local window = cmp.config.window.bordered()
    window.border = vim.g.border
    window = nil -- noice, lsp_signature
    -- ~~~~~~~~~~~~~~~~~~ insert mode ~~~~~~~~~~~~~~~~~~~ --
    --- @diagnostic disable-next-line: redundant-parameter
    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ['<tab>'] = wrap_snippet_jump(1),
        ['<s-tab>'] = wrap_snippet_jump(-1),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- override select = false
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
      }),
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources({
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        {
          name = 'path',
          option = { trailing_slash = true },
        },
        { name = 'emoji' },
      }),
      window = {
        completion = window,
        documentation = window,
      },
      view = {
        entries = {
          name = 'custom',
          selection_order = 'near_cursor', -- (lower = better) ---> (closer to cursor = better)
        },
      },
      formatting = {
        format = require('lspkind').cmp_format({
          mode = 'symbol_text',
          menu = {
            buffer = 'buf',
            nvim_lsp = 'lsp',
            luasnip = 'snp',
            emoji = 'emj',
            nvim_lua = 'lua',
            latex_symbols = 'ltx',
          },
        }),
      },
      sorting = {
        comparators = {
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.kind,
          -- cmp.config.compare.scopes, -- super slow on big files in command line, https://github.com/hrsh7th/nvim-cmp/issues/1681
          cmp.config.compare.locality,
          cmp.config.compare.offset,
          require('clangd_extensions.cmp_scores'),
        },
      },
      preselect = cmp.PreselectMode.None,
    })
    -- ~~~~~~~~~~~~~~~~~~~~ cmdline ~~~~~~~~~~~~~~~~~~~~~ --
    cmp.setup.cmdline(':', {
      completion = { autocomplete = false },
      mapping = cmp.mapping.preset.cmdline(),
      view = {
        entries = 'custom',
      },
      sources = cmp.config.sources(
        { { name = 'path', option = { trailing_slash = true } } },
        { { name = 'cmdline', option = { ignore_cmds = { 'Man', '!' } } } }
      ),
    })
  end,
}

specs.luasnip = {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  dependencies = {
    'rafamadriz/friendly-snippets',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
  -- if build fails, install jsregexp luarock (or don't, this is optoinal)
  build = 'make install_jsregexp',
}

return u.values(specs)
