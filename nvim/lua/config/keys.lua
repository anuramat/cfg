local M = {}

local u = require('utils')

local function nmap(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { silent = true, desc = "Keys: " .. desc })
end
local function vmap(lhs, rhs, desc)
  vim.keymap.set("v", lhs, rhs, { silent = true, desc = "Keys: " .. desc })
end
local function imap(lhs, rhs, desc)
  vim.keymap.set("i", lhs, rhs, { silent = true, desc = "Keys: " .. desc })
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Built-in ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
vim.g.mapleader = " "
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true, desc = "Keys: Leader Key" })
vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { silent = true, desc = "Keys: Exit from terminal insert mode" })

nmap("<leader>bn", ":bn<cr>", "Next Buffer")
nmap("<leader>bp", ":bp<cr>", "Buffer")
nmap("<leader>bd", ":bd<cr>", "Buffer")
nmap("<leader>bD", ":bd!<cr>", "Delete Buffer (forced)")

nmap("<leader>qc", ":ccl<cr>", "Close Quickfix")

-- Scroll with centered cursor
nmap("<c-u>", "<c-u>zz", "Scroll up")
nmap("<c-d>", "<c-d>zz", "Scroll down")

-- Move lines
nmap("<a-j>", "<cmd>m .+1<cr>==", "Move line down")
nmap("<a-k>", "<cmd>m .-2<cr>==", "Move line up")
imap("<a-j>", "<esc><cmd>m .+1<cr>==gi", "Move line down")
imap("<a-k>", "<esc><cmd>m .-2<cr>==gi", "Move line up")
vmap("<a-j>", ":m '>+1<cr>gv=gv", "Move line down")
vmap("<a-k>", ":m '<-2<cr>gv=gv", "Move line up")
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Homegrown ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
nmap("<leader>#", require("config.macros").CreateCommentHeader, "Create comment header")
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ LSP ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.lsp_set = function(buffer)
  local n = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = buffer, desc = 'LSP: ' .. desc })
  end

  local function list_workspace_folders()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end

  n('<leader>lr', vim.lsp.buf.rename, 'Rename')
  n('<leader>lf', vim.lsp.buf.format, 'Format Buffer')
  n('<leader>la', vim.lsp.buf.code_action, 'Code Action')
  n('<leader>ll', vim.lsp.codelens.run, 'CodeLens')

  n('K', vim.lsp.buf.hover, 'Hover Documentation')
  n('gd', vim.lsp.buf.definition, 'Definition')
  n('gD', vim.lsp.buf.declaration, 'Declaration')
  n('gi', vim.lsp.buf.implementation, 'Implementation')
  n('go', vim.lsp.buf.type_definition, 'Type Definition')
  n('gr', vim.lsp.buf.references, 'References')
  n('gs', vim.lsp.buf.signature_help, 'Signature Help')
  n('gl', vim.diagnostic.open_float, 'Show Diagnostic')
  n('[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
  n(']d', vim.diagnostic.goto_next, 'Next Diagnostic')

  n('<leader>lwa', vim.lsp.buf.add_workspace_folder, 'Add Workspace Folder')
  n('<leader>lwr', vim.lsp.buf.remove_workspace_folder, 'Remove Workspace Folder')
  n('<leader>lwl', list_workspace_folders, 'List Workspace Folders')
end
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Trouble ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.trouble_lazy = function()
  local function d(x)
    return "Trouble: " .. x
  end
  return {
    { "<leader>tt", "<cmd>TroubleToggle<cr>",                 desc = d("Toggle") },
    { "<leader>tD", "<cmd>Trouble workspace_diagnostics<cr>", desc = d("Workspace Diagnostics") },
    { "<leader>td", "<cmd>Trouble document_diagnostics<cr>",  desc = d("Document Diagnostics") },
    { "<leader>tl", "<cmd>Trouble loclist <cr>",              desc = d("Location List") },
    { "<leader>tq", "<cmd>Trouble quickfix<cr>",              desc = d("QuickFix") },
    { "<leader>tr", "<cmd>Trouble lsp_references<cr>",        desc = d("LSP References") },
    { "<leader>tR", "<cmd>TroubleRefresh<cr>",                desc = d("Refresh") },
    { "<leader>tc", "<cmd>TroubleClose<cr>",                  desc = d("Close") },
  }
end
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Flash ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.flash_lazy = function()
  local function d(x)
    return "Flash: " .. x
  end
  return {
    { "s", mode = { "n", },     function() require("flash").jump() end,       desc = d("Jump") },
    { "S", mode = { "n", "o" }, function() require("flash").treesitter() end, desc = d("Treesitter") },
    { "r", mode = { "o" },      function() require("flash").remote() end,     desc = d("Remote") },
  }
end
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TreeSJ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.treesj_lazy = function()
  return { {
    "<leader>m",
    mode = { "n" },
    function()
      require("treesj").toggle()
    end,
    desc = "TreeSJ: Toggle"
  } }
end
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ CMP ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.cmp_custom = {
  c = function()
    local cmp = require('cmp')
    return {
      -- So that completion doesn't block the cmdline window
      ['C-f'] =
          function()
            if cmp.visible() then
              cmp.abort()
            end
            u.press('C-f')
          end
      ,
      ['<C-n>'] = cmp.config.disable,
      ['<C-p>'] = cmp.config.disable,
    }
  end,
  i = function()
    local cmp = require('cmp')
    return {
      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    }
  end
}

return M
