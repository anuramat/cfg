local specs = {}
local u = require("utils")
local icons = require("config.icons")

specs.dracula_cs = {
  "dracula/vim",
  lazy = false,
}

specs.fidget = {
  "j-hui/fidget.nvim",
  tag = "legacy",
}

specs.lualine = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    return {
      options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
        refresh = { statusline = 300, tabline = 1000, winbar = 1000, },
      },
      extensions = { "fugitive", "lazy", "quickfix", "trouble", "symbols-outline", "man" },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = {
              left = 1,
              right = 0,
            },
          },
          { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
        },
        lualine_x = {
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = " ",
            },
          },
        },
        lualine_y = {
          {
            function()
              return "  " .. require("dap").status()
            end,
            cond = function()
              return package.loaded["dap"] and require("dap").status() ~= ""
            end,
            color = u.fg("Debug"),
          },
        },
        lualine_z = {
          { "progress", separator = "",                   padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
      },
      tabline = {
        lualine_a = { { "buffers", show_filename_only = false, hide_filename_extension = true, mode = 4 } },
        lualine_z = { { "tabs" } },
      },
    }
  end,
}

specs.trouble = {
  "folke/trouble.nvim",
  event = "VeryLazy", -- lsp attach?
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
}

specs.bqf = {
  "kevinhwang91/nvim-bqf",
  event = "VeryLazy",
  opts = {},
  dependencies = { "nvim-treesitter/nvim-treesitter" },
}

specs.indentline = {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    char = "│",
    filetype_exclude = {
      "help",
      "Trouble",
      "lazy",
    },
    show_trailing_blankline_indent = false,
    show_current_context = false,
  },
}

-- ufo - folds
-- noice
-- notify/notifier

return u.respec(specs)
