local M = {}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--- Returns configs for specific lsps
--- @return table configs
M.cfgs = function()
  return {
    nixd = {}, -- kinda worse than nil_ls, but being rewritten rn
    nil_ls = {}, -- no formatting
    yamlls = {},
    texlab = {},
    bashls = {},
    pyright = {},
    marksman = {},
    clangd = {
      on_attach = function(client, buffer)
        vim.api.nvim_buf_set_keymap(
          buffer,
          'n',
          '<leader>sh',
          '<cmd>ClangdSwitchSourceHeader<cr>',
          { silent = true, desc = 'clangd: Switch between .c/.h' }
        )
        require('lsp.utils').default_on_attach(client, buffer)
        require('clangd_extensions.inlay_hints').setup_autocmd()
        require('clangd_extensions.inlay_hints').set_inlay_hints()
      end,
      filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' }, -- 'proto' removed
    },
    gopls = {
      settings = {
        gopls = {
          analyses = {
            fieldalignment = true,
            shadow = true,
            unusedwrite = true,
            useany = true,
            unusedvariable = true,
          },
          codelenses = {
            gc_details = true,
            generate = true,
            regenerate_cgo = true,
            tidy = true,
            upgrade_dependency = true,
            vendor = true,
          },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          usePlaceholders = true,
          staticcheck = true,
          gofumpt = true,
          semanticTokens = true,
        },
      },
      root_dir = require('lsp.utils').root_dir_with_fallback({
        primary = { '.git' },
        fallback = { 'go.work', 'go.mod' },
      }),
    },
    lua_ls = {
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          workspace = {
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    },
  }
end

return M
