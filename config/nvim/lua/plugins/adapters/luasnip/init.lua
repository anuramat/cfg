return {
  'L3MON4D3/LuaSnip',
  dependencies = {
    'anuramat/friendly-snippets',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
  -- if build fails, install jsregexp luarock (or don't, this is optoinal)
  build = 'make install_jsregexp',
}
