local specs = {}

local u = require('utils')

local function press(rawkey)
  local key = vim.api.nvim_replace_termcodes(rawkey, true, true, true)
  vim.api.nvim_feedkeys(key, 'n', false)
end

local function next(fb_key)
  return function()
    local cmp = require('cmp')
    if cmp.visible() then
      cmp.select_next_item()
    elseif fb_key ~= nil then
      press(fb_key)
    else
      cmp.complete()
    end
  end
end

local function prev(fb_key)
  return function()
    local cmp = require('cmp')
    if cmp.visible() then
      cmp.select_prev_item()
    elseif fb_key ~= nil then
      press(fb_key)
    else
      cmp.complete()
    end
  end
end

local function confirm(fb_key)
  return function()
    local cmp = require('cmp')
    if cmp.visible() or fb_key == nil then
      cmp.confirm({ select = fb_key ~= nil })
    elseif fb_key ~= nil then
      press(fb_key)
    end
  end
end

local function abort(ptkey)
  return function()
    require('cmp').abort()
    if ptkey ~= nil then
      press(ptkey)
    end
  end
end

local function d(text)
  return 'CMP: ' .. text
end


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
  keys = {
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ insert mode ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    { '<c-n>',   next(),          mode = 'i',          desc = d('Next') },
    { '<c-p>',   prev(),          mode = 'i',          desc = d('Prev') },
    { '<cr>',    confirm("<cr>"), mode = 'i',          desc = d('Select') },
    { '<tab>',   next("<tab>"),   mode = 'i',          desc = d('Next') },
    { '<s-tab>', prev("<s-tab>"), mode = 'i',          desc = d('Prev') },
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ common ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    { '<c-y>',   confirm(),       mode = { 'i', 'c' }, desc = d('Select') },
    { '<c-e>',   abort(),         mode = 'i',          desc = d('Abort') },
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ cmdline ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    { '<c-e>',   abort(),         mode = 'c',          desc = d('Abort') },
    { '<c-f>',   abort("<c-f>"),  mode = 'c',          desc = d('Abort and Passthrough') },
    { '<c-z>',   next(),          mode = 'c',          desc = d('Next') },
    { '<tab>',   next(),          mode = 'c',          desc = d('Next') },
    { '<s-tab>', prev(),          mode = 'c',          desc = d('Prev') },
  },
  config = function()
    local cmp = require("cmp")
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ insert mode ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    cmp.setup({
      snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end, },
      sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'luasnip' } }, { { name = 'buffer' } })
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
