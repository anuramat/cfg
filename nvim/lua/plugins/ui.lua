local specs = {}

local u = require("utils")

specs.dracula_cs = {
  "dracula/vim",
  lazy = false,
}

specs.fidget = {
  "j-hui/fidget.nvim",
  tag = "legacy",
}


specs.indentline = {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    char = "│",
    filetype_exclude = {
      "help",
      "Trouble",
      "lazy",
    },
    show_trailing_blankline_indent = false,
    show_current_context = false,
  },
}


return u.respec(specs)
