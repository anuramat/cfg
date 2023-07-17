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

specs.trouble = {
  "folke/trouble.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  keys = {
    { "gR", "<cmd>Trouble lsp_references<cr>", desc = "Trouble: LSP References" }
  }
}

specs.bqf = {
  "kevinhwang91/nvim-bqf",
  event = "VeryLazy",
  opts = {},
  dependencies = { "nvim-treesitter/nvim-treesitter" },
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
