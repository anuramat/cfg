local keys = {}
local specs = {}

local map = require("config.utils").lazy_map
local tele = require("telescope")
local builtin = require("telescope.builtin")

keys.zoxide = {
  map("<Leader>j", function()
    tele.extensions.zoxide.list()
  end, "Telescope pickers"),
}

keys.telescope = {
  map("<Leader><Leader>", builtin.builtin, "Telescope Builtin"),
  map("<Leader>o", builtin.find_files, "Find Files"),
  map("<Leader>b", builtin.buffers, "Buffers"),
  map("<Leader>g", builtin.live_grep, "Live Grep"),
  map("<Leader>s", builtin.lsp_document_symbols, "LSP Document Symbols"),
  map("<Leader>S", builtin.lsp_dynamic_workspace_symbols, "LSP Dynamic Workspace Symbols"),
}

specs.telescope = {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = keys.telescope,
  config = function()
    local z_utils = require("telescope._extensions.zoxide.utils")
    tele.setup({
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

local result = {}
for _, value in pairs(specs) do
  table.insert(result, value)
end
return result
