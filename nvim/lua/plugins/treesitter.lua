local specs = {}

local u = require("utils")

local languages = {
  "go", "python", "haskell", "bash", "c", "json", "lua", "luadoc", "luap",
  "markdown", "markdown_inline", "python", "query", "regex", "vim", "vimdoc",
  "yaml",
}

specs.treesitter = {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- last release is way too old
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  cmd = { "TSUpdateSync" },
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = languages,
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    textobjects = {
      swap = {
        enable = true,
        swap_next = { ["<c-j>"] = "@parameter.inner" },
        swap_previous = { ["<c-k>"] = "@parameter.inner" },
      },
    },
  },
  config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
}

return u.respec(specs)
