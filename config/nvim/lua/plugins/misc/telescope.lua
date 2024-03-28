local u = require('utils')

-- uses fd for find_files
-- rg for everything else
return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'jvgrootveld/telescope-zoxide',
    'nvim-telescope/telescope-symbols.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
    {
      'nvim-telescope/telescope-live-grep-args.nvim',
      version = '^1.0.0',
    },
  },
  keys = u.lazy_prefix('<leader>f', {
    { 'G', '<cmd>Telescope live_grep_args<cr>', desc = 'Live Grep' },
    { 'S', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', desc = 'Dynamic Workspace Symbols' },
    { 'b', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
    { 'd', '<cmd>Telescope diagnostics<cr>', desc = 'Workspace Diagnostics' },
    { 'g', '<cmd>Telescope live_grep<cr>', desc = 'Live Grep' },
    { 'h', '<cmd>Telescope harpoon marks<cr>', desc = 'Harpoons' },
    { 'j', '<cmd>Telescope zoxide list<cr>', desc = 'Zoxide' },
    { 'm', '<cmd>Telescope marks<cr>', desc = 'Marks' },
    { 'o', '<cmd>Telescope find_files<cr>', desc = 'Files' },
    { 'p', '<cmd>Telescope builtin<cr>', desc = 'Pickers' },
    { 'r', '<cmd>Telescope lsp_references<cr>', desc = 'References' },
    { 's', '<cmd>Telescope lsp_document_symbols<cr>', desc = 'Document Symbols' },
  }, 'Tele'),
  config = function()
    require('telescope').load_extension('zoxide')
    require('telescope').load_extension('fzf')
    require('telescope').load_extension('live_grep_args')
    local opts = {
      defaults = {
        wrap_results = true,
        layout_config = {
          horizontal = {
            preview_width = 120,
            height = 999,
            preview_cutoff = 140,
            width = 999,
          },
        },
        prompt_prefix = ' ',
        selection_caret = ' ',
        multi_icon = ' ',
        path_display = { 'truncate' },
        dynamic_preview_title = true,
        -- border = false,
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
        },
      },
      pickers = {
        keymaps = { show_plug = false },
        colorscheme = { enable_preview = false },
        buffers = { sort_mru = true },
      },
    }
    if vim.g.border == 'solid' then
      opts.defaults.borderchars = {
        prompt = { '' },
        results = { '' },
        preview = { '' },
      }
    end
    require('telescope').setup(opts)
  end,
}
