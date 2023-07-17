local specs = {}
local keys = {}

u = require("utils")

keys.flash = {
  { "s", mode = { "n", },     function() require("flash").jump() end,       desc = "Flash" },
  { "S", mode = { "n", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  { "r", mode = { "o" },      function() require("flash").remote() end,     desc = "Remote Flash" },
}

keys.treesj = {
  {
    "<leader>m",
    mode = { "n" },
    function()
      require("treesj").toggle()
    end
  },
  desc = "TreeSJ: Toggle"
}

specs.surround = {
  "kylechui/nvim-surround",
  version = "*", -- use last release instead of main
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({})
  end
}

specs.flash =
{
  "folke/flash.nvim",
  opts = { modes = { search = { enabled = false } } },
  keys = keys.flash,
}

specs.treesj = {
  'Wansmer/treesj',
  event = { "BufReadPost", "BufNewFile" },
  version = false,
  opts = { use_default_keymaps = false },
  keys = keys.treesj
}

return u.respec(specs)
