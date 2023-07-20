local specs = {}

local u = require("utils")

local keys = {}

local builtin = require("telescope.builtin")
-- vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
-- vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
-- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
-- vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
-- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
keys.telescope = {
  { "<leader>fp", builtin.builtin,                       desc = "Telescope: Builtin" },
  { "<leader>fo", builtin.find_files,                    desc = "Telescope: Find Files" },
  { "<leader>fb", builtin.buffers,                       desc = "Telescope: Buffers" },
  { "<leader>fg", builtin.live_grep,                     desc = "Telescope: Live Grep" },
  { "<leader>fs", builtin.lsp_document_symbols,          desc = "Telescope: LSP Document Symbols" },
  { "<leader>fS", builtin.lsp_dynamic_workspace_symbols, desc = "Telescope: LSP Dynamic Workspace Symbols" },
  {'<leader>f/',
    function()
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
       winblend = 10,
       previewer = false, 
       }))
    end,
    desc = 'Telescope: Fuzzy Buffer Search' }
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
        find_files = { hidden = true, file_ignore_patterns = { "%.[^/]+/" } },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        zoxide = { prompt_title = "Zoxide" },
      },
    })
    require("telescope").load_extension("fzf")
  end,
}

specs.fzf = {
  "nvim-telescope/telescope-fzf-native.nvim",
  build = "make",
}

specs.zoxide = {
  "jvgrootveld/telescope-zoxide",
  keys = {
    {
      "<leader>fj",
      function() require("telescope").extensions.zoxide.list() end,
      desc = "Zoxide: Jump"
    }
  },
  config = function()
    require("telescope").load_extension("zoxide")
  end
}

return u.respec(specs)
