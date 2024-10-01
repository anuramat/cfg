return {
  'folke/todo-comments.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  opts = {
    sign_priority = -1000,
    highlight = {
      keyword = 'bg', -- only highlight the word
      pattern = [[<(KEYWORDS)>]], -- vim regex
      multiline = false, -- enable multine todo comments
    },
    search = {
      pattern = [[\b(KEYWORDS)\b]], -- ripgrep regex
    },
  },
}
