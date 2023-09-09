local M = {}
local fu = require('fmt')
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Intro ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
-- NOTE Might wanna keep this in sync with which-key
local s = vim.keymap.set
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ LSP ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
function M.lsp(buffer)
  local function n(keys, func, desc)
    s('n', keys, func, { buffer = buffer, desc = 'LSP: ' .. desc })
  end

  local function list_workspace_folders()
    vim.print(vim.lsp.buf.list_workspace_folders())
  end

  local function references()
    vim.lsp.buf.references({ includeDeclaration = false })
  end
  n('<leader>lr', vim.lsp.buf.rename, 'Rename symbol')
  n('<leader>lf', fu.format, 'Format buffer')
  n('<leader>la', vim.lsp.buf.code_action, 'Code action')
  n('<leader>ll', vim.lsp.codelens.run, 'CodeLens')

  n('K', vim.lsp.buf.hover, 'Hover Documentation')
  n('gd', vim.lsp.buf.definition, 'Definition')
  n('gD', vim.lsp.buf.declaration, 'Declaration')
  n('gi', vim.lsp.buf.implementation, 'Implementation')
  n('go', vim.lsp.buf.type_definition, 'Type Definition')
  n('gr', references, 'References')
  n('gs', vim.lsp.buf.signature_help, 'Signature Help')
  n('gl', vim.diagnostic.open_float, 'Show Diagnostic')
  n('[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
  n(']d', vim.diagnostic.goto_next, 'Next Diagnostic')

  n('<leader>lwa', vim.lsp.buf.add_workspace_folder, 'Add Workspace Folder')
  n('<leader>lwr', vim.lsp.buf.remove_workspace_folder, 'Remove Workspace Folder')
  n('<leader>lwl', list_workspace_folders, 'List Workspace Folders')
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ miniAI ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
function M.miniai()
  local ts = require('mini.ai').gen_spec.treesitter
  return {
    b = false, -- = ([{
    q = false, -- = `'"
    -- ~~~~~~~~~~~~~~~~~~~ functions ~~~~~~~~~~~~~~~~~~~ --
    F = ts({
      a = { '@function.outer' },
      i = { '@function.inner' },
    }, {}),
    f = ts({
      a = { '@call.outer' },
      i = { '@call.inner' },
    }),
    a = ts({
      a = { '@parameter.outer' },
      i = { '@parameter.inner' },
    }),
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    e = ts({
      a = { '@assignment.outer' },
      i = { '@assignment.rhs' },
    }),
    r = ts({
      a = { '@return.outer' },
      i = { '@return.inner' },
    }),
    -- ~~~~~~~~~~~~~~~~~~~~~ misc ~~~~~~~~~~~~~~~~~~~~~~ --
    s = ts({ -- structs/classes; instance/definition
      a = { '@class.outer' },
      i = { '@class.inner' },
    }, {}),
    c = ts({ -- inner doesn't work with most languages, use outer
      a = { '@comment.outer' },
      i = { '@comment.inner' },
    }),
    o = ts({ -- any other blocks
      a = { '@block.outer', '@conditional.outer', '@loop.outer', '@frame.outer' },
      i = { '@block.inner', '@conditional.inner', '@loop.inner', '@frame.inner' },
    }, {}),
  }
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ UndoTree ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
function M.undotree()
  local function d(x)
    return 'UndoTree: ' .. x
  end
  return {
    {
      '<leader>u',
      '<cmd>UndotreeToggle<cr>',
      desc = d('Toggle'),
    },
  }
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TreeSitter ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.treesitter = {
  textobj_swap = {
    swap_next = { ['<a-l>'] = '@parameter.inner' },
    swap_previous = { ['<a-h>'] = '@parameter.inner' },
  },
}
return M
