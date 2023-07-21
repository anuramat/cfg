local specs = {}

local u = require("utils")

local cfgs = {}

cfgs.bashls = {}
cfgs.pyright = {}

cfgs.gopls = {
  gopls = {
    analyses = {
      fieldalignment = true,
      nilness = true,
      shadow = true,
      unusedparams = true,
      unusedwrite = true,
      useany = true,
      unusedvariable = true,
    },
    staticcheck = true,
    gofumpt = true,
  },
}

cfgs.lua_ls = {
  Lua = {
    runtime = {
      version = 'LuaJIT',
    },
    workspace = {
      checkThirdParty = false,
      library = vim.api.nvim_get_runtime_file("*", true),
    },
    telemetry = {
      enable = false,
    },
  },
}

specs.neodev = { "folke/neodev.nvim", opts = {} }

specs.lspconfig = {
  "neovim/nvim-lspconfig",
  event = { "VeryLazy", "BufReadPost", "BufNewFile" },
  dependencies = {
    "folke/neodev.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local lspconfig = require("lspconfig")

    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ formatting ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    local on_attach = function(_, bufnr)
      local group = vim.api.nvim_create_augroup("LSP Formatting", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = group,
        callback = function()
          local client = vim.lsp.get_active_clients()[1]
          if client and client.server_capabilities.documentFormattingProvider then
            vim.lsp.buf.format({ async = false })
            return
          else
          end
        end,
      })

      -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ bindings ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
      local nmap = function(keys, func, desc)
        desc = 'LSP: ' .. desc
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end
      local function list_workspace_folders()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end

      nmap('<leader>lr', vim.lsp.buf.rename, 'Rename')
      nmap('<leader>lf', vim.lsp.buf.format, 'Format Buffer')
      nmap('<leader>la', vim.lsp.buf.code_action, 'Code Action')
      nmap('<leader>lc', vim.lsp.codelens.run, 'CodeLens')

      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('gd', vim.lsp.buf.definition, 'Definition')
      nmap('gD', vim.lsp.buf.declaration, 'Declaration')
      nmap('gi', vim.lsp.buf.implementation, 'Implementation')
      nmap('go', vim.lsp.buf.type_definition, 'Type Definition')
      nmap('gr', vim.lsp.buf.references, 'References')
      nmap('gs', vim.lsp.buf.signature_help, 'Signature Help')
      nmap('gl', vim.diagnostic.open_float, 'Show Diagnostic')
      nmap('[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
      nmap(']d', vim.diagnostic.goto_next, 'Next Diagnostic')

      nmap('<leader>lwa', vim.lsp.buf.add_workspace_folder, 'Add Workspace Folder')
      nmap('<leader>lwr', vim.lsp.buf.remove_workspace_folder, 'Remove Workspace Folder')
      nmap('<leader>lwl', list_workspace_folders, 'List Workspace Folders')
    end

    -- ~~~~~~~~~~~~~~~~~~~~~ configure lsps and completion ~~~~~~~~~~~~~~~~~~~~~ --
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    for server, settings in pairs(cfgs) do
      lspconfig[server].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = settings,
      })
    end
  end,
}

specs.saga = {
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  config = function()
    require('lspsaga').setup({})
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  }
}

return u.respec(specs)
