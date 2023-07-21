local specs = {}

local u = require('utils')

local keys = {}

local builtin = require('telescope.builtin')
local function tfuz()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end
local function d(i)
  return 'Telescope: ' .. i
end

keys.telescope = {
  { '<leader>fp', builtin.builtin,                       desc = d('Pickers') },
  { '<leader>fo', builtin.find_files,                    desc = d('Find Files') },
  { '<leader>fb', builtin.buffers,                       desc = d('Buffers') },
  { '<leader>fg', builtin.live_grep,                     desc = d('Live Grep') },
  { '<leader>f/', tfuz,                                  desc = d('Fuzzy Buffer Search') },
  { '<leader>fh', builtin.help_tags,                     desc = d('Help') },
  { '<leader>fs', builtin.lsp_document_symbols,          desc = d('LSP Document Symbols') },
  { '<leader>fS', builtin.lsp_dynamic_workspace_symbols, desc = d('LSP Dynamic Workspace Symbols') },
  { '<leader>fr', builtin.lsp_references,                desc = d('LSP References') },
  { '<leader>fd', builtin.diagnostics,                   desc = d('LSP Diagnostics') },
}

specs.telescope = {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = keys.telescope,
  config = function()
    local telescope = require('telescope')
    telescope.setup({
      pickers = {
        find_files = { hidden = true, file_ignore_patterns = { '%.[^/]+/' } },
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
  keys = {
    {
      '<leader>fj',
      function() require('telescope').extensions.zoxide.list() end,
      desc = 'Zoxide: Jump'
    }
  },
  config = function()
    require('telescope').load_extension('zoxide')
  end
}

return u.respec(specs)
