return {
  -- converts ipynb to py on read, back - on save
  -- requires jupytext in path
  'goerz/jupytext.vim',
  lazy = false,
  init = function()
    vim.g.jupytext_fmt = 'py'
  end,
}
