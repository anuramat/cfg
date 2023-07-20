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
    { "<leader>dc",  function() require("dap").continue() end,          desc = "DAP: Continue", },
    { "<leader>dn",  function() require("dap").step_over() end,         desc = "DAP: Step Over", },
    { "<leader>di",  function() require("dap").step_into() end,         desc = "DAP: Step Into", },
    { "<leader>do",  function() require("dap").step_out() end,          desc = "DAP: Step Out", },
    { "<leader>dt",  function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle Breakpoint", },
    { "<leader>tf",  bp_cond,                                           desc = "DAP: Breakpoint with condition" },
    { "<leader>db",  function() require("dap").set_breakpoint() end,    desc = "DAP: Set Breakpoint" },
    { "<leader>dlp", bp_log,                                            desc = "DAP: Log point" },
    { "<leader>dr",  function() require("dap").repl.open() end,         desc = "DAP: REPL" },
    { "<leader>dl",  function() require("dap").run_last() end,          desc = "DAP: Run Last" },


    {
      "<leader>dh",
      function() require("dap.ui.widgets").hover() end,
      mode = { "n", "v" },
      desc = "DAP: Hover",
    },
    {
      "<leader>dp",
      function() require("dap.ui.widgets").preview() end,
      mode = { "n", "v" },
      desc = "DAP: Preview",
    },
    {
      mode = "n",
      "<leader>df",
      function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.frames)
      end,
      desc = "DAP: Frames"
    },
    {
      "<leader>ds",
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
