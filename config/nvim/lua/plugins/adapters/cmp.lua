-- vim: fdl=1

local setup_cmdline = function()
  local cmp = require('cmp')
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
end

--- Jump to a snippet field
--- Fallback is called if jump isn't possible
--- @param jump_size integer Relative position of the target field
--- @return function mapping
local wrap_snippet_jump = function(jump_size)
  local luasnip = require('luasnip')
  return function(fallback)
    if luasnip.locally_jumpable(jump_size) then
      luasnip.jump(jump_size)
    else
      fallback()
    end
  end
end

---@diagnostic disable: undefined-field
local setup_insert = function()
  local cmp = require('cmp')
  local window = cmp.config.window.bordered()
  window = nil -- turn off because of noice and lsp_signature
  -- TODO check if we need window again

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
      { name = 'otter' },
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

return {
  'hrsh7th/nvim-cmp',
  branch = 'main',
  dependencies = {
    'L3MON4D3/LuaSnip',
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
    setup_insert()
    setup_cmdline()
  end,
}
