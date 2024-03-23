-- TODO try it

return {
  'nvim-neorg/neorg',
  dependencies = { 'nvim-lua/plenary.nvim' },
  build = ':Neorg sync-parsers',
  -- tag = "*",
  -- event = 'VeryLazy',
  ft = 'norg', -- lazy load on file type
  cmd = 'Neorg', -- lazy load on command
  config = function()
    require('neorg').setup({
      load = {
        ['core.defaults'] = {}, -- Loads default behaviour
        ['core.concealer'] = {}, -- Adds pretty icons to your documents
        ['core.dirman'] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = '~/notes',
            },
          },
        },
      },
    })
  end,
}
