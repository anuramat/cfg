local specs = {}

local u = require("utils")
local k = require('config.keys')

local langs = {
  "go", "gosum", "gomod", "gowork", "python", "haskell", "bash", "c", "json",
  "lua", "luadoc", "luap", "markdown", "markdown_inline", "python", "query",
  "regex", "vim", "vimdoc", "yaml", "sql"
}

specs.treesitter = {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- last release is way too old
  build = ":TSUpdate",
  event = { "VeryLazy", "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  opts = {
    highlight = { enable = true },
    indent = { enable = true, disable = { "python" } }, -- tab indent doesn't work on python
    ensure_installed = langs,
    incremental_selection = {
      enable = true,
      keymaps = k.treesitter.inc_selection,
    },
    textobjects = {
      swap = u.merge({ enable = true }, k.treesitter.textobj_swap)
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false, -- Comment.nvim takes care of this
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
return u.values(specs)
