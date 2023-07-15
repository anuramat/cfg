local specs = {}
local opts = {}
local configs = {}
local keys = {}
local etc = {}

specs.todo = {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
}

local result = {}
for _, value in pairs(specs) do
  table.insert(result, value)
end
return result
