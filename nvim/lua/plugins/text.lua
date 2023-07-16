local specs = {}
local keys = {}

keys.flash = {
  { "s", mode = { "n", },     function() require("flash").jump() end,       desc = "Flash" },
  { "S", mode = { "n", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  { "r", mode = { "o" },      function() require("flash").remote() end,     desc = "Remote Flash" },
}

specs.surround = {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({})
  end
}

specs.flash =
{
  "folke/flash.nvim",
  opts = {},
  keys = keys.flash,
}

specs.treesj = {
  'Wansmer/treesj',
  event = { "BufReadPost", "BufNewFile" },
  version = false,
  opts = { use_default_keymaps = false },
  keys = {
    {
      "<leader>m",
      mode = { "n" },
      function()
        require("treesj").toggle()
      end
    },

    desc = "TreeSJ: Toggle"
  }
}


local result = {}
for _, value in pairs(specs) do
  table.insert(result, value)
end
return result
