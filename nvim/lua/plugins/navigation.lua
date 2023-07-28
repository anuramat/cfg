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

local function d(x)
  return "Trouble: " .. x
end
specs.trouble = {
  "folke/trouble.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  keys = {
    { "<leader>tt", "<cmd>TroubleToggle<cr>",                 desc = d("Toggle") },
    { "<leader>tD", "<cmd>Trouble workspace_diagnostics<cr>", desc = d("Workspace Diagnostics") },
    { "<leader>td", "<cmd>Trouble document_diagnostics<cr>",  desc = d("Document Diagnostics") },
    { "<leader>tl", "<cmd>Trouble loclist <cr>",              desc = d("Location List") },
    { "<leader>tq", "<cmd>Trouble quickfix<cr>",              desc = d("QuickFix") },
    { "<leader>tr", "<cmd>Trouble lsp_references<cr>",        desc = d("LSP References") },
    { "<leader>tR", "<cmd>TroubleRefresh<cr>",                desc = d("Refresh") },
    { "<leader>tc", "<cmd>TroubleClose<cr>",                  desc = d("Close") },
  }
}

specs.bqf = {
  "kevinhwang91/nvim-bqf",
  event = "VeryLazy",
  opts = {},
  dependencies = { "nvim-treesitter/nvim-treesitter" },
}

specs.harpoon = {
  'ThePrimeagen/harpoon',
  keys = {
    { "<leader>ha", function() require("harpoon.mark").add_file() end,        desc = "Harpoon: Add File" },
    { "<leader>hl", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon: List Files" },
    { "<leader>hp", function() require("harpoon.ui").nav_prev() end,          desc = "Harpoon: Prev File" },
    { "<leader>hn", function() require("harpoon.ui").nav_next() end,          desc = "Harpoon: Next File" },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    tabline = true
  }
}

return u.respec(specs)
