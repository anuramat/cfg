local specs = {}

local u = require("utils")

specs.dap = {
  "mfussenegger/nvim-dap",
  keys = {
    { "<space>pp", function() require("dap").continue() end,          desc = "DAP: Continue" },
    { "<space>pa", function() require("dap").step_over() end,         desc = "DAP: Step Over" },
    { "<space>pb", function() require("dap").step_into() end,         desc = "DAP: Step Into" },
    { "<space>pc", function() require("dap").step_out() end,          desc = "DAP: Step Out" },
    { "<space>pd", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle Breakpoint" },
    {
      "<space>pf",
      function()
        vim.ui.input({ prompt = "Breakpoint condition:" }, function(input)
          if input == nil then
            return
          end
          require("dap").set_breakpoint(input)
        end)
      end,
      desc = "DAP:  Breakpoint"
    },
    { "<space>pe", function() require("dap").continue() end, desc = "DAP: Toggle Breakpoint" },
  }
}

specs.ui = { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" }, opts = {} }

return u.respec(specs)
