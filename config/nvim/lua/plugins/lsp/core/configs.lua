local on_attach = require('plugins.lsp.core.on_attach')

--- Root directory function with a fallback
--- @param opts { primary: string[], fallback: string[] }
local root_dir_with_fallback = function(opts)
  local util = require('lspconfig.util')
  return function(fname)
    local primary_root = util.root_pattern(unpack(opts.primary))(fname)
    local fallback_root = util.root_pattern(unpack(opts.fallback))(fname)
    return primary_root or fallback_root
  end
end

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--- Returns configs for specific lsps
--- @return table configs
return function()
  return {
    nixd = {}, -- kinda worse than nil_ls, but being rewritten rn
    nil_ls = {},
    yamlls = {},
    texlab = {},
    bashls = {},
    pyright = {},
    -- marksman = {}, -- I use obsidian.nvim btw
    clangd = {
      on_attach = function(client, buffer)
        vim.api.nvim_buf_set_keymap(
          buffer,
          'n',
          '<leader>sh',
          '<cmd>ClangdSwitchSourceHeader<cr>',
          { silent = true, desc = 'clangd: Switch between .c/.h' }
        )
        on_attach(client, buffer)
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
      root_dir = root_dir_with_fallback({
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
          -- workspace = {
          --   checkThirdParty = 'Disable', -- already in .luarc.json
          -- },
          format = {
            enable = false, -- using stylua instead
          },
          -- hint = {
          --   enable = true, -- kinda annoying
          -- },
          telemetry = {
            enable = false,
          },
        },
      },
    },
  }
end
