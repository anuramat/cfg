local specs = {}
local k = require('plugkeys')
local u = require('utils')

specs.todo = {
  'folke/todo-comments.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim' },
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

specs.trouble = {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = k.trouble(),
  keykey,
}

specs.treesj = {
  'Wansmer/treesj',
  version = false,
  opts = {
    use_default_keymaps = false,
    max_join_length = 500,
  },
  keys = k.treesj,
}

specs.comment = {
  -- TODO: move to space-comment?
  'numToStr/Comment.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'JoosepAlviste/nvim-ts-context-commentstring' },
  config = function()
    require('Comment').setup({
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    })
  end,
  keys = {
    { 'gc', mode = { 'n', 'x' } },
    { 'gb', mode = { 'n', 'x' } },
  },
}

return u.values(specs)
