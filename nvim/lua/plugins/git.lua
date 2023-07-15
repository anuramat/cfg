local keys = {}
local specs = {}


specs.fugitive = {
    "tpope/vim-fugitive"
}

specs.signs = {
    "lewis6991/gitsigns.nvim",
    opts = {
        signs = {
            add = { text = "+", },
            change = { text = "~" },
            delete = { text = "_", },
            topdelete = { text = "‾", },
            changedelete = { text = "~", },
        },
    },
}


local result = {}
for _, value in pairs(specs) do
    table.insert(result, value)
end
return result
