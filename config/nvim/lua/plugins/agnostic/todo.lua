return {
  'folke/todo-comments.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  opts = {
    sign_priority = -1000,
    highlight = {
      keyword = 'bg',
      pattern = [[<(KEYWORDS)>]], -- vim regex
    },
    search = {
      pattern = [[\b(KEYWORDS)\b]], -- ripgrep regex
    },
  },
}
