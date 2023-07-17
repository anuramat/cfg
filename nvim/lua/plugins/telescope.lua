local keys = {}
local specs = {}

local u = require("utils")

keys.zoxide = {
  {
    "<Leader>j",
    function()
      require("telescope").extensions.zoxide.list()
    end,
    desc = "Zoxide: jump"
  }
}

local builtin = require("telescope.builtin")
keys.telescope = {
  { "<Leader><Leader>", builtin.builtin,                       desc = "Telescope Builtin" },
  { "<Leader>o",        builtin.find_files,                    desc = "Find Files" },
  { "<Leader>b",        builtin.buffers,                       desc = "Buffers" },
  { "<Leader>f",        builtin.live_grep,                     desc = "Live Grep" },
  { "<Leader>s",        builtin.lsp_document_symbols,          desc = "LSP Document Symbols" },
  { "<Leader>S",        builtin.lsp_dynamic_workspace_symbols, desc = "LSP Dynamic Workspace Symbols" },
}

specs.telescope = {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = keys.telescope,
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      pickers = {
        find_files = {
          hidden = true,
          file_ignore_patterns = { "%.[^/]+/" },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        zoxide = {
          prompt_title = "Zoxide",
        },
      },
    })
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("zoxide")
  end,
}

specs.fzf = {
  "nvim-telescope/telescope-fzf-native.nvim",
  build = "make",
  dependencies = { "nvim-telescope/telescope.nvim" },
}

specs.zoxide = {
  "jvgrootveld/telescope-zoxide",
  keys = keys.zoxide,
  dependencies = { "nvim-telescope/telescope.nvim" },
}

return u.respec(specs)
