local specs = {}
local u = require('utils')

-- Highlights and searches comment tags like XXX
-- Generic plugin
specs.todo = {
  'folke/todo-comments.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  opts = {
    highlight = {
      keyword = 'bg',
      pattern = [[<(KEYWORDS)>]], -- vim regex
    },
    search = {
      pattern = [[\b(KEYWORDS)\b]], -- ripgrep regex
    },
  },
}

-- Quickfix replacement
specs.trouble = {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- stylua: ignore
  keys = u.prefix('<leader>t', {
    { 't', '<cmd>TroubleToggle<cr>',                 desc = 'Toggle' },
    { 'D', '<cmd>Trouble workspace_diagnostics<cr>', desc = 'Workspace Diagnostics' },
    { 'd', '<cmd>Trouble document_diagnostics<cr>',  desc = 'Document Diagnostics' },
    { 'l', '<cmd>Trouble loclist <cr>',              desc = 'Location List' },
    { 'q', '<cmd>Trouble quickfix<cr>',              desc = 'Quickfix' },
    { 'r', '<cmd>Trouble lsp_references<cr>',        desc = 'LSP References' },
    { 'R', '<cmd>TroubleRefresh<cr>',                desc = 'Refresh' },
    { 'c', '<cmd>TroubleClose<cr>',                  desc = 'Close' },
  }),
}

-- Splits/joins code blocks based on Treesitter
specs.treesj = {
  'Wansmer/treesj',
  version = false,
  opts = {
    use_default_keymaps = false,
    max_join_length = 500,
  },
  keys = {
    {
      '<leader>j',
      function()
        require('treesj').toggle()
      end,
      desc = 'Split/Join TS node',
    },
  },
}

-- -- Splits/joins code blocks based on special per-language rules
-- specs.splitjoin = {
--   'AndrewRadev/splitjoin.vim',
--   lazy = false,
--   config = function()
--     vim.g.splitjoin_split_mapping = '<leader>J'
--     vim.g.splitjoin_join_mapping = '<leader>j'
--   end,
-- }

-- Comments lines
-- Generic plugin, see also:
-- tpope/vim-commentary
specs.comment = {
  'numToStr/Comment.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'JoosepAlviste/nvim-ts-context-commentstring' },
  config = function()
    --- @diagnostic disable-next-line: missing-fields
    require('Comment').setup({
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      toggler = {
        line = '<leader>cc',
        block = '<leader>bc',
      },
      opleader = {
        line = '<leader>c',
        block = '<leader>b',
      },
    })
  end,
  keys = {
    { '<leader>c', mode = { 'n', 'x' }, desc = 'Comment' },
  },
}

return u.values(specs)
