local specs = {}

local u = require("utils")

specs.lualine = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "arkav/lualine-lsp-progress" },
  opts = function()
    return {
      options = {
        theme = "dracula-nvim",
        section_separators = { left = "", right = "" },
        component_separators = { left = "\\", right = "/" },
        globalstatus = true,
        refresh = { statusline = 300, tabline = 1000, winbar = 1000, },
      },
      extensions = { "fugitive", "lazy", "quickfix", "trouble", "man", "nvim-dap-ui" },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { { "branch", icon = "󰊢" } },
        lualine_c = { { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } }, },
        lualine_x = { { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " ", }, }, },
        lualine_y = {
          { "lsp_progress" },
          {
            function()
              return "  " .. require("dap").status()
            end,
            cond = function()
              return package.loaded["dap"] and require("dap").status() ~= ""
            end,
          },
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
      -- winbar = {}, inactive_winbar = { lualine_c = { "filename" } },
    }
  end,
}

return u.values(specs)
