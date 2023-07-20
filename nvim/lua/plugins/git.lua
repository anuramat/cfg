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
      map({ "n", "v" }, "<Leader>gs", ":Gitsigns stage_hunk<CR>", "Gitsigns: Stage Hunk")
      map({ "n", "v" }, "<Leader>gr", ":Gitsigns reset_hunk<CR>", "Gitsigns: Reset Hunk")
      map("n", "<Leader>gS", gs.stage_buffer, "Gitsigns: Stage Buffer")
      map("n", "<Leader>gR", gs.reset_buffer, "Gitsigns: Reset Buffer")
      map("n", "<Leader>gu", gs.undo_stage_hunk, "Gitsigns: Undo Stage Hunk")
      map("n", "<Leader>gp", gs.preview_hunk, "Gitsigns: Preview Hunk")
      map("n", "<Leader>gb", function() gs.blame_line({ full = true }) end, "Gitsigns: Blame Line")
      map("n", "<Leader>gd", gs.diffthis, "Gitsigns: Diff This")
      map("n", "<Leader>gD", function() gs.diffthis("~") end, "Gitsigns: Diff This ~")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns: Select Hunk")
    end,
  },
}

return u.respec(specs)
