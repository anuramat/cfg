local specs = {}

local utils = require("utils")
local icons = require("icons")

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

        theme = "auto",
        globalstatus = true,
      },

      tabline = {
        lualine_a = { "buffers" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "tabs" },
      },
      extensions = { "fugitive", "lazy", "quickfix", "trouble", "symbols-outline", "man" },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
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
            function()
              return require("noice").api.status.command.get()
            end,
            cond = function()
              return package.loaded["noice"] and require("noice").api.status.command.has()
            end,
            color = utils.fg("Statement"),
          },
          {
            function()
              return require("noice").api.status.mode.get()
            end,
            cond = function()
              return package.loaded["noice"] and require("noice").api.status.mode.has()
            end,
            color = utils.fg("Constant"),
          },
          {
            function()
              return "  " .. require("dap").status()
            end,
            cond = function()
              return package.loaded["dap"] and require("dap").status() ~= ""
            end,
            color = utils.fg("Debug"),
          },
          {},
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
          },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return " " .. os.date("%R")
          end,
        },
      },
    }
  end,
}

specs.which = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function() -- maybe remove TODO
    vim.o.timeout = true
    vim.o.timeoutlen = 1000
  end,
  opts = {},
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
  dependencies = { "kevinhwang91/promise-async" },
}

specs.dressing = {
  "stevearc/dressing.nvim",
  lazy = true,
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
  keys = {
    {
      "<leader>un",
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      desc = "Dismiss all Notifications",
    },
  },
  opts = {
    timeout = 3000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
  },
  init = function()
    -- when noice is not enabled, install notify on VeryLazy
    if not utils.has("noice.nvim") then
      utils.on_very_lazy(function()
        vim.notify = require("notify")
      end)
    end
  end,
}

specs.indentline = {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    -- char = "▏",
    char = "│",
    filetype_exclude = {
      "help",
      "alpha",
      "dashboard",
      "neo-tree",
      "Trouble",
      "lazy",
      "mason",
      "notify",
      "toggleterm",
      "lazyterm",
    },
    show_trailing_blankline_indent = false,
    show_current_context = false,
  },
}

specs.nui = { "MunifTanjim/nui.nvim", lazy = true }
specs.noice = {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
    },
  },
  -- stylua: ignore
  keys = {
    {
      "<S-Enter>",
      function() require("noice").redirect(vim.fn.getcmdline()) end,
      mode = "c",
      desc =
      "Redirect Cmdline"
    },
    {
      "<leader>snl",
      function() require("noice").cmd("last") end,
      desc =
      "Noice Last Message"
    },
    {
      "<leader>snh",
      function() require("noice").cmd("history") end,
      desc =
      "Noice History"
    },
    { "<leader>sna", function() require("noice").cmd("all") end,     desc = "Noice All" },
    { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    {
      "<c-f>",
      function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
      silent = true,
      expr = true,
      desc =
      "Scroll forward",
      mode = {
        "i", "n", "s" }
    },
    {
      "<c-b>",
      function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
      silent = true,
      expr = true,
      desc =
      "Scroll backward",
      mode = {
        "i", "n", "s" }
    },
  },
}

local result = {}
for _, value in pairs(specs) do
  table.insert(result, value)
end
return result
