local specs = {}

local u = require("utils")

local function get_num_mappings()
  local res = {}
  for i = 1, 9 do
    res[i] = {
      "<leader>h" .. tostring(i),
      function() require("harpoon.ui").nav_file(i) end,
      desc = "Harpoon: File #" .. tostring(i)
    }
  end
  return res
end

specs.harpoon = {
  'ThePrimeagen/harpoon',
  keys = {
    { "<leader>ha", function() require("harpoon.mark").add_file() end,        desc = "Harpoon: Add File" },
    { "<leader>hl", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon: List Files" },
    { "<leader>hp", function() require("harpoon.ui").nav_prev() end,          desc = "Harpoon: Prev File" },
    { "<leader>hn", function() require("harpoon.ui").nav_next() end,          desc = "Harpoon: Next File" },
    unpack(get_num_mappings()),
  },
  dependencies = {
    'nvim-lua/plenary.nvim', },
  opts = {
    --   tabline = true
  }
}

return u.respec(specs)
