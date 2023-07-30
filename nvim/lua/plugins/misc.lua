local specs = {}

local u = require("utils")
local k = require("config.keys")

specs.dracula_cs = {
  "Mofiqul/dracula.nvim",
  lazy = false,
  priority = 1337
}

specs.indentline = {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
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

specs.surround = {
  "kylechui/nvim-surround",
  version = "*",      -- use last release instead of main
  event = "VeryLazy", -- TODO lazier
  opts = {
    keymaps = k.surround
  },
}

specs.treesj = {
  'Wansmer/treesj',
  -- event = "VeryLazy",
  versio = false,
  opts = { use_default_keymaps = false },
}

specs.comment = {
  "numToStr/Comment.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "JoosepAlviste/nvim-ts-context-commentstring" },
  event        = "VeryLazy",
  config       = function()
    local opts = k.comment
    opts.pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
    require("Comment").setup(opts)
  end,
}

specs.ai = {
  "echasnovski/mini.ai",
  event = "VeryLazy", -- TODO lazier
  dependencies = { "nvim-treesitter-textobjects" },
  opts = function()
    return {
      n_lines = 500,
      custom_textobjects = k.miniai(),
    }
  end,
}

specs.flash = {
  "folke/flash.nvim",
  opts = { modes = { search = { enabled = false } } },
  keys = k.flash(),
}

specs.todo = {
  "folke/todo-comments.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    highlight = {
      pattern = [[.*<(KEYWORDS)\s*]]
    }
  },
}

specs.trouble = {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = k.trouble(),
  opts = {},
}

specs.bqf = {
  "kevinhwang91/nvim-bqf",
  event = { "BufReadPre", "BufNewFile", "VeryLazy" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {},
}

specs.sleuth = {
  "tpope/vim-sleuth",
  event = { "BufReadPre", "BufNewFile", "VeryLazy" },
}

specs.undotree = {
  'mbbill/undotree',
  cmd = {
    "UndotreeHide",
    "UndotreeShow",
    "UndotreeFocus",
    "UndotreeToggle",
  },
  keys = k.undotree(),
}

specs.marks = {
  'chentoast/marks.nvim',
  event = "VeryLazy",
  opts = {},
}

return u.values(specs)
