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
  opts = {},
}

specs.trouble = {
  "folke/trouble.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  keys = {
    { "<Leader>tt", "<cmd>TroubleToggle<CR>",                       desc = "Trouble: Toggle" },
    { "<Leader>tD", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Trouble: Workspace Diagnostics" },
    { "<Leader>td", "<cmd>TroubleToggle document_diagnostics<CR>",  desc = "Trouble: Document Diagnostics" },
    { "<Leader>tl", "<cmd>TroubleToggle loclist <CR>",              desc = "Trouble: Location List" },
    { "<Leader>tq", "<cmd>TroubleToggle quickfix<CR>",              desc = "Trouble: QuickFix" },
    { "<Leader>tr", "<cmd>TroubleToggle lsp_references<CR>",        desc = "Trouble: LSP References" },
  }
}

specs.bqf = {
  "kevinhwang91/nvim-bqf",
  event = "VeryLazy",
  opts = {},
  dependencies = { "nvim-treesitter/nvim-treesitter" },
}

return u.respec(specs)
