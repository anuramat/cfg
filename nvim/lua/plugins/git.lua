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
      map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<cr>", "Gitsigns: Stage Hunk")
      map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<cr>", "Gitsigns: Reset Hunk")
      map("n", "<leader>gS", gs.stage_buffer, "Gitsigns: Stage Buffer")
      map("n", "<leader>gR", gs.reset_buffer, "Gitsigns: Reset Buffer")
      map("n", "<leader>gu", gs.undo_stage_hunk, "Gitsigns: Undo Stage Hunk")
      map("n", "<leader>gp", gs.preview_hunk, "Gitsigns: Preview Hunk")
      map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Gitsigns: Blame Line")
      map("n", "<leader>gd", gs.diffthis, "Gitsigns: Diff This")
      map("n", "<leader>gD", function() gs.diffthis("~") end, "Gitsigns: Diff This ~")
      map({ "o", "x" }, "ih", ":<c-u>Gitsigns select_hunk<cr>", "Gitsigns: Select Hunk")
    end,
  },
}

return u.values(specs)
