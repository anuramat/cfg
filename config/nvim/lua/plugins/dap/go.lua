return {
  'leoluz/nvim-dap-go',
  ft = 'go',
  opts = {
    dap_configurations = {
      {
        type = 'go',
        name = 'Attach remote',
        mode = 'remote',
        request = 'attach',
      },
    },
    delve = {
      path = 'dlv',
      initialize_timeout_sec = 20,
      port = '${port}', -- ${port} for random port
      args = {}, -- additional args to pass to delve
      build_flags = '', -- build flags to pass to delve (because flags from args are ignored in dap mode)
    },
  },
}
