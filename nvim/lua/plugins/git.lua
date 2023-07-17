local specs = {}

local u = require('utils')

specs.fugitive = {
  "tpope/vim-fugitive",
  event = "VeryLazy",
}

specs.signs = {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns
      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      map("n", "]h", gs.next_hunk, "Gitsigns: Next Hunk")
      map("n", "[h", gs.prev_hunk, "Gitsigns: Prev Hunk")
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Gitsigns: Stage Hunk")
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Gitsigns: Reset Hunk")
      map("n", "<leader>ghS", gs.stage_buffer, "Gitsigns: Stage Buffer")
      map("n", "<leader>ghu", gs.undo_stage_hunk, "Gitsigns: Undo Stage Hunk")
      map("n", "<leader>ghR", gs.reset_buffer, "Gitsigns: Reset Buffer")
      map("n", "<leader>ghp", gs.preview_hunk, "Gitsigns: Preview Hunk")
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Gitsigns: Blame Line")
      map("n", "<leader>ghd", gs.diffthis, "Gitsigns: Diff This")
      map("n", "<leader>ghD", function() gs.diffthis("~") end, "Gitsigns: Diff This ~")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns: Select Hunk")
    end,
  },
}

return u.respec(specs)
