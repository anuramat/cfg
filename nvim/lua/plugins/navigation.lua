local specs = {}

local u = require("utils")

specs.flash = {
  "folke/flash.nvim",
  opts = { modes = { search = { enabled = false } } },
  keys = {
    { "s", mode = { "n", },     function() require("flash").jump() end,       desc = "Flash" },
    { "S", mode = { "n", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = { "o" },      function() require("flash").remote() end,     desc = "Remote Flash" },
  }
}

specs.todo = {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
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

return u.respec(specs)
