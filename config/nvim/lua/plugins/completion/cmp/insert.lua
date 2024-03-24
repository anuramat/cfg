---@diagnostic disable: undefined-field
return function()
  local cmp = require('cmp')
  local wrap_snippet_jump = require('plugins.completion.luasnip.jump')
  local window = cmp.config.window.bordered()
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
        -- cmp.config.compare.scopes,
        -- super slow on big files in command line
        -- https://github.com/hrsh7th/nvim-cmp/issues/1681
        cmp.config.compare.locality,
        cmp.config.compare.offset,
        require('clangd_extensions.cmp_scores'),
      },
    },
    preselect = cmp.PreselectMode.None,
  })
end
