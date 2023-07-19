local specs = {}

local u = require("utils")

specs.dracula_cs = {
  "Mofiqul/dracula.nvim",
  lazy = false,
}

specs.indentline = {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    char = "│",
    filetype_exclude = {
      "TelescopePrompt",
      "Trouble",
      "checkhealth",
      "help",
      "lazy",
      "lspinfo",
      "man",
      "quickfix",
    },
    show_trailing_blankline_indent = false,
    show_current_context = false,
  },
}


return u.respec(specs)
