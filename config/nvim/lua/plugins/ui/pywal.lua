return {
  lazy = false,
  'uZer/pywal16.nvim',
  as = 'pywal16',
  config = function()
    local pywal16 = require('pywal16')
    pywal16.setup()
  end,
}
