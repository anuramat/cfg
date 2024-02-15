local specs = {}
local u = require('utils')

--- Confirm selection, first entry if there's no selection
--- Fallback is called if menu isn't visible
--- @return function mapping
local function confirm()
  return function(fallback)
    local cmp = require('cmp')
    if cmp.visible() then
      local entry = cmp.get_selected_entry()
      if not entry then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        cmp.confirm()
      else
        cmp.confirm()
      end
    else
      fallback()
    end
  end
end

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

--- Select next entry, with fallback
--- @param opts? { force_complete: boolean }  Open completion menu instead of calling fallback
--- @return function mapping
local function cmp_next(opts)
  local cmp = require('cmp')
  return function(fallback)
    if not cmp.visible() then
      if opts == nil or not opts.force_complete then
        fallback()
        return
      end
      cmp.complete()
    end
    cmp.select_next_item()
  end
end

--- Select previous entry, with fallback
--- @param opts? { force_complete: boolean }  Open completion menu instead of calling fallback
--- @return function mapping
local function cmp_prev(opts)
  local cmp = require('cmp')
  return function(fallback)
    if not cmp.visible() then
      if opts == nil or not opts.force_complete then
        fallback()
        return
      end
      cmp.complete()
    end
    cmp.select_prev_item()
  end
end

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
    local mapping = cmp.mapping
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ insert mode setup ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    -- ~~~~~~~~~~~~~~~~~~~~~~ keys ~~~~~~~~~~~~~~~~~~~~~~ --
    local insert_keys = {
      ['<c-y>'] = confirm(),
      ['<c-e>'] = mapping.abort(),
      ['<tab>'] = wrap_snippet_jump(1),
      ['<s-tab>'] = wrap_snippet_jump(-1),
      ['<c-n>'] = cmp_next({ force_complete = true }),
      ['<c-p>'] = cmp_prev({ force_complete = true }),
    }
    -- ~~~~~~~~~~~~~~~~~~~~~ setup ~~~~~~~~~~~~~~~~~~~~~~ --
    cmp.setup({
      mapping = insert_keys,
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      sources = cmp.config.sources(
        { { name = 'luasnip' }, { name = 'nvim_lsp' } },
        { { name = 'buffer' } },
        { { name = 'path', option = { trailing_slash = true } } }
      ),
      window = { documentation = cmp.config.window.bordered() },
      sorting = {
        comparators = {
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.kind,
          -- cmp.config.compare.scopes, -- super slow on big files in command line
          cmp.config.compare.locality,
          cmp.config.compare.offset,
          require('clangd_extensions.cmp_scores'),
        },
      },
      preselect = cmp.PreselectMode.None,
    })
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ cmdline setup ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    -- ~~~~~~~~~~~~~~~~~~~~~~ keys ~~~~~~~~~~~~~~~~~~~~~~ --
    -- BUG: for some reason mappings need to be wrapped in cmp.mapping explicitly for cmdline:
    -- [key] = cmp.mapping({ c = function })
    local cmdline_keys = {
      ['<c-z>'] = { c = cmp_next({ force_complete = true }) },
      ['<tab>'] = { c = cmp_next({ force_complete = true }) },
      ['<s-tab>'] = { c = cmp_prev() },
      ['<c-e>'] = { c = mapping.abort() },
      ['<c-y>'] = { c = mapping.confirm({ select = false }) },
      ['<c-n>'] = { c = cmp_next() },
      ['<c-p>'] = { c = cmp_prev() },
    }
    local cmdline_interrupters = { '<c-f>', '<c-d>' }
    for _, hotkey in pairs(cmdline_interrupters) do -- this fixes BUG: cmp menu gets stuck on c_^f
      cmdline_keys[hotkey] = mapping({
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
      completion = { autocomplete = false },
      mapping = cmdline_keys,
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
  -- if build fails, install jsregexp luarock
  build = 'echo \'NOTE: jsregexp is optional, so not a big deal if it fails to build\'; make install_jsregexp',
}

return u.values(specs)
