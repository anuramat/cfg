local keys = {}
local specs = {}

specs.haskell = {
    "mrcjkb/haskell-tools.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    branch = "1.x.x",
}

specs.mdpreview = {
    "iamcco/markdown-preview.nvim",
    cmd = {
        "MarkdownPreview",
        "MarkdownPreviewStop",
        "MarkdownPreviewToggle",
    },
    config = function()
        vim.fn["mkdp#util#install"]()
    end,
}

local result = {}
for _, value in pairs(specs) do
    table.insert(result, value)
end
return result
