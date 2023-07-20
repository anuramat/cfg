local specs = {}

local u = require("utils")

local function bp_cond()
  vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
    if not input then
      return
    end
    require("dap").set_breakpoint(nil, input, nil)
  end)
end

local function bp_log()
  vim.ui.input({ prompt = "Log point message: " }, function(input)
    if not input then
      return
    end
    require("dap").set_breakpoint(nil, nil, input)
  end)
end

specs.dap = {
  "mfussenegger/nvim-dap",
  keys = {
    { "<Leader>dc",  function() require("dap").continue() end,          desc = "DAP: Continue", },
    { "<Leader>dn",  function() require("dap").step_over() end,         desc = "DAP: Step Over", },
    { "<Leader>di",  function() require("dap").step_into() end,         desc = "DAP: Step Into", },
    { "<Leader>do",  function() require("dap").step_out() end,          desc = "DAP: Step Out", },
    { "<Leader>dt",  function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle Breakpoint", },
    { "<Leader>tf",  bp_cond,                                           desc = "DAP: Breakpoint with condition" },
    { "<Leader>db",  function() require("dap").set_breakpoint() end,    desc = "DAP: Set Breakpoint" },
    { "<Leader>dlp", bp_log,                                            desc = "DAP: Log point" },
    { "<Leader>dr",  function() require("dap").repl.open() end,         desc = "DAP: REPL" },
    { "<Leader>dl",  function() require("dap").run_last() end,          desc = "DAP: Run Last" },


    {
      "<Leader>dh",
      function() require("dap.ui.widgets").hover() end,
      mode = { "n", "v" },
      desc = "DAP: Hover",
    },
    {
      "<Leader>dp",
      function() require("dap.ui.widgets").preview() end,
      mode = { "n", "v" },
      desc = "DAP: Preview",
    },
    {
      mode = "n",
      "<Leader>df",
      function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.frames)
      end,
      desc = "DAP: Frames"
    },
    {
      "<Leader>ds",
      function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes)
      end,
      desc = "DAP: Scopes"
    },
  },
}

specs.ui = { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" }, opts = {} }

return u.respec(specs)
