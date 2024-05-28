return {
  'lukas-reineke/lsp-format.nvim',
  opts = function()
    local config = {
      lua = {
        exclude = {
          'lua_ls',
        },
      },
      nix = {
        exclude = {
          'nixd',
          'nil_ls',
        },
      },
    }

    -- -- use sync formatting if not specified
    -- for _, v in pairs(vim.fn.getcompletion('', 'filetype')) do
    --   if not config[v] then
    --     config[v] = {}
    --   end
    --   if config[v].sync == nil then
    --     config[v].sync = true
    --   end
    -- end

    return config
  end,
}
