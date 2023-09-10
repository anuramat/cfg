local specs = {}
local u = require('utils')

local function current_buffer_fuzzy_find()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
    winblend = vim.o.winblend,
    previewer = false,
  }))
end

specs.telescope = {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  -- stylua: ignore
  keys = u.prefix('<leader>f', {
    { '/', current_buffer_fuzzy_find,                                  desc = 'Fuzzy Search' },
    { 'S', require('telescope.builtin').lsp_dynamic_workspace_symbols, desc = 'Dynamic Workspace Symbols', },
    { 'b', require('telescope.builtin').buffers,                       desc = 'Buffers' },
    { 'd', '<cmd>Telescope harpoon marks<cr>',                         desc = 'Harpoons' },
    { 'd', require('telescope.builtin').diagnostics,                   desc = 'Diagnostics' },
    { 'g', require('telescope.builtin').live_grep,                     desc = 'Live Grep' },
    { 'm', require('telescope.builtin').marks,                         desc = 'Marks' },
    { 'o', require('telescope.builtin').find_files,                    desc = 'Files' },
    { 'p', require('telescope.builtin').builtin,                       desc = 'Pickers' },
    { 'r', require('telescope.builtin').lsp_references,                desc = 'References' },
    { 's', require('telescope.builtin').lsp_document_symbols,          desc = 'Document Symbols' },
  }),
  config = function()
    local telescope = require('telescope')
    telescope.setup({
      defaults = {
        vimgrep_arguments = {
          -- required
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          -- custom
          '--ignore',
        },
      },
      pickers = {
        keymaps = { show_plug = false },
        colorscheme = { enable_preview = true },
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
      '<leader>fz',
      function()
        require('telescope').extensions.zoxide.list()
      end,
      desc = 'Zoxide',
    },
  },
  config = function()
    require('telescope').load_extension('zoxide')
  end,
}

return u.values(specs)
