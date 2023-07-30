local specs = {}

local u = require('utils')
local k = require('config.keys')

specs.telescope = {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = k.telescope_lazy(),
  config = function()
    local telescope = require('telescope')
    telescope.setup({
      pickers = {
        find_files = { hidden = true, file_ignore_patterns = { '%.[^/]+/' } },
        keymaps = { show_plug = false },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
        zoxide = { prompt_title = 'Zoxide' },
      },
    })
    require('telescope').load_extension('fzf')
  end,
}

specs.fzf = {
  'nvim-telescope/telescope-fzf-native.nvim',
  build = 'make',
}

specs.zoxide = {
  'jvgrootveld/telescope-zoxide',
  keys = k.zoxide_lazy(),
  config = function()
    require('telescope').load_extension('zoxide')
  end
}

return u.values(specs)
