local specs = {}

local u = require("utils")

specs.dap = {
  "mfussenegger/nvim-dap",
  keys = {
    { "<Leader>dc", function() require("dap").continue() end,          desc = "DAP: Continue" },
    { "<Leader>dv", function() require("dap").step_over() end,         desc = "DAP: Step Over" },
    { "<Leader>di", function() require("dap").step_into() end,         desc = "DAP: Step Into" },
    { "<Leader>du", function() require("dap").step_out() end,          desc = "DAP: Step Out" },
    { "<Leader>dt", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle Breakpoint" },
    {
      "<Leader>tf",
      desc = "DAP:  Breakpoint with condition"
    },
    { '<Leader>db',  function() require('dap').set_breakpoint() end },
    { '<Leader>dlp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end },
    { '<Leader>dr',  function() require('dap').repl.open() end },
    { '<Leader>dl',  function() require('dap').run_last() end },
    {
      '<Leader>dh',
      function() require('dap.ui.widgets').hover() end,
      mode = {
        'n', 'v' },
    },
    {
      '<Leader>dp',
      function() require('dap.ui.widgets').preview() end,
      mode = {
        'n', 'v' },
    },
    {
      mode = 'n',
      '<Leader>df',
      function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.frames)
      end
    },
    {
      '<Leader>ds', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.scopes)
    end
    }
  }
}

specs.ui = { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" }, opts = {} }

return u.respec(specs)
