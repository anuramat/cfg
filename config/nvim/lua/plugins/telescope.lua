local specs = {}
local u = require('utils')

local function picker(name)
  return function()
    require('telescope.builtin')[name](require('telescope.themes').get_ivy({
      winblend = vim.o.winblend,
    }))
  end
end

specs.telescope = {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  -- stylua: ignore
  keys = u.prefix('<leader>f', {
    { '/', picker('current_buffer_fuzzy_find'),                                  desc = 'Fuzzy search' },
    { 'S', picker('lsp_dynamic_workspace_symbols'), desc = 'Dynamic workspace symbols', },
    { 'b', picker('buffers'),                       desc = 'Buffers' },
    { 'd', picker('diagnostics'),                   desc = 'Diagnostics' },
    { 'g', picker('live_grep'),                     desc = 'Live grep' },
    { 'G', picker('grep_string'),                   desc = 'Grep word under cursor' },
    { 'm', picker('marks'),                         desc = 'Marks' },
    { 'o', picker('find_files'),                    desc = 'Files' },
    { 'p', picker('builtin'),                       desc = 'Pickers' },
    { 'r', picker('lsp_references'),                desc = 'References' },
    { 's', picker('lsp_document_symbols'),          desc = 'Document symbols' },
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
        winblend = vim.o.winblend,
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
