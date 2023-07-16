local specs = {}

local u = require("config.utils")
local icons = require("config.icons")

specs.dracula_cs = {
  "dracula/vim",
  lazy = false,
}

specs.fidget = { "j-hui/fidget.nvim", opts = {}, tag = "legacy" }

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
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
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

specs.outline = {
  "simrat39/symbols-outline.nvim",
  event = "VeryLazy",
  opts = { use_default_keymaps = false },
}

specs.bqf = {
  "kevinhwang91/nvim-bqf",
  event = "VeryLazy",
  opts = {},
  dependencies = { "nvim-treesitter/nvim-treesitter" },
}

specs.ufo = {
  "kevinhwang91/nvim-ufo",
  event = "VeryLazy",
  dependencies = { "kevinhwang91/promise-async" },
}

specs.dressing = {
  "stevearc/dressing.nvim",
  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(...)
      require("lazy").load({ plugins = { "dressing.nvim" } })
      return vim.ui.select(...)
    end
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.input = function(...)
      require("lazy").load({ plugins = { "dressing.nvim" } })
      return vim.ui.input(...)
    end
  end,
}

specs.notify = {
  "rcarriga/nvim-notify",
  event = 'VeryLazy',
  keys = {
    {
      "<leader>un",
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      desc = "Dismiss all Notifications",
    },
  },
  config = function(a, b)
    vim.notify = require("notify")
    return {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    }
  end,
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
      "notify",
    },
    show_trailing_blankline_indent = false,
    show_current_context = false,
  },
}

-- TODO when stable : https://github.com/folke/noice.nvim
-- https://github.com/rcarriga/nvim-notify

local result = {}
for _, value in pairs(specs) do
  table.insert(result, value)
end
return result
