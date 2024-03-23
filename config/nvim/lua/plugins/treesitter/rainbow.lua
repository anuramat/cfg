-- treesitter based rainbow parentheses
-- alterntaives:
-- * https://github.com/luochen1990/rainbow -- 1.7k stars
-- * https://github.com/junegunn/rainbow_parentheses.vim -- junegunn, seems "complete", 374 stars
return {
  'HiPhish/rainbow-delimiters.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'BufEnter',
}
