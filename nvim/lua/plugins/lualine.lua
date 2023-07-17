local specs = {}

local u = require("utils")

specs.lualine = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    return {
      options = {
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
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
          { "filetype" },
        },
        lualine_z = {
          { "progress", padding = { left = 1, right = 0 }, separator = "" },
          { "location", padding = { left = 1, right = 1 } },
        },
      },
      tabline = {
        lualine_a = { { "buffers", show_filename_only = false, hide_filename_extension = true, mode = 4 } },
        lualine_z = { { "tabs" } },
      },
    }
  end,
}

return u.respec(specs)
