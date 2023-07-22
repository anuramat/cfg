local specs = {}

local u = require("utils")

specs.mdpreview = {
  "iamcco/markdown-preview.nvim",
  config = function()
    vim.fn["mkdp#util#install"]()
  end,
}

return u.respec(specs)
