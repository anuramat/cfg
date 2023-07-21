local specs = {}

local u = require("utils")

specs.flash = {
  "folke/flash.nvim",
  opts = { modes = { search = { enabled = false } } },
  keys = {
    { "s", mode = { "n", },     function() require("flash").jump() end,       desc = "Flash: Jump" },
    { "S", mode = { "n", "o" }, function() require("flash").treesitter() end, desc = "Flash: Treesitter" },
    { "r", mode = { "o" },      function() require("flash").remote() end,     desc = "Flash: Remote" },
  }
}

specs.todo = {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    highlight = {
      pattern = [[.*<(KEYWORDS)\s*]]
    }
  },
}

specs.trouble = {
  "folke/trouble.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  keys = {
    { "<leader>tt", "<cmd>TroubleToggle<cr>",                       desc = "Trouble: Toggle" },
    { "<leader>tD", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble: Workspace Diagnostics" },
    { "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Trouble: Document Diagnostics" },
    { "<leader>tl", "<cmd>TroubleToggle loclist <cr>",              desc = "Trouble: Location List" },
    { "<leader>tq", "<cmd>TroubleToggle quickfix<cr>",              desc = "Trouble: QuickFix" },
    { "<leader>tr", "<cmd>TroubleToggle lsp_references<cr>",        desc = "Trouble: LSP References" },
  }
}

specs.bqf = {
  "kevinhwang91/nvim-bqf",
  event = "VeryLazy",
  opts = {},
  dependencies = { "nvim-treesitter/nvim-treesitter" },
}

return u.respec(specs)
