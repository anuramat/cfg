local specs = {}

local u = require("utils")

specs.mdpreview = {
  "iamcco/markdown-preview.nvim",
  ft = 'markdown',
  config = function()
    vim.fn["mkdp#util#install"]()
    vim.g.mkdp_auto_close = 0
  end,
}

return u.respec(specs)
