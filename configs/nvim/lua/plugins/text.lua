local specs = {}
local keys = {}

keys.flash = {
  { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
  { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
  { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
  { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
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
  event = "VeryLazy",
  opts = {},
  keys = keys.flash
}

specs.treesj = {
  'Wansmer/treesj',
  version = false,
  keys = {
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function() require('treesj').setup() end,
}


local result = {}
for _, value in pairs(specs) do
  table.insert(result, value)
end
return result
