local M = {}
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Intro ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
-- For the most part mappings look like this:
-- <Leader><ModuleMnemonic><FunctionMnemonic>
-- Closely integrated mappings do not (have to) conform to this "rule".
local s = vim.keymap.set
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ LSP ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
function M.lsp(buffer)
  local function n(keys, func, desc)
    s('n', keys, func, { buffer = buffer, desc = 'LSP: ' .. desc })
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

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Trouble ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
function M.trouble()
  local function d(x) return 'Trouble: ' .. x end
  return {
    { '<leader>tt', '<cmd>TroubleToggle<cr>',                 desc = d('Toggle') },
    { '<leader>tD', '<cmd>Trouble workspace_diagnostics<cr>', desc = d('Workspace Diagnostics') },
    { '<leader>td', '<cmd>Trouble document_diagnostics<cr>',  desc = d('Document Diagnostics') },
    { '<leader>tl', '<cmd>Trouble loclist <cr>',              desc = d('Location List') },
    { '<leader>tq', '<cmd>Trouble quickfix<cr>',              desc = d('Quickfix') },
    { '<leader>tr', '<cmd>Trouble lsp_references<cr>',        desc = d('LSP References') },
    { '<leader>tR', '<cmd>TroubleRefresh<cr>',                desc = d('Refresh') },
    { '<leader>tc', '<cmd>TroubleClose<cr>',                  desc = d('Close') },
  }
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Flash ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
function M.flash()
  local function d(x) return 'Flash: ' .. x end
  return {
    { 's', mode = 'n',          function() require('flash').jump() end,       desc = d('Jump') },
    { 'r', mode = 'o',          function() require('flash').remote() end,     desc = d('Remote') },
    { 'S', mode = { 'n', 'o' }, function() require('flash').treesitter() end, desc = d('Treesitter') },
    -- register default mappings for lazy loading
    't', 'T',
    'f', 'F',
  }
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TreeSJ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.treesj = { {
  '<leader>j',
  function() require('treesj').toggle() end,
  desc = 'TreeSJ: Toggle'
} }
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ CMP ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
-- for the most part using cmp defaults
-- trying to match default vim ins/cmdline-completion hotkeys
M.cmp =
{
  main = function()
    local luasnip = require('luasnip')
    local cmp = require('cmp')
    return {
      ['<tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<s-tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }
  end,
  cmdline = function()
    -- BUG: for some reason mappings need to be wrapped explicitly for cmdline:
    -- [key] = cmp.mapping({ c = function })
    local interrupters = { '<c-f>', '<c-d>' }
    local cmp = require('cmp')
    local result = {
      ['<c-n>'] = cmp.mapping({ c = cmp.config.disable }),
      ['<c-p>'] = cmp.mapping({ c = cmp.config.disable }),
    }
    for _, hotkey in pairs(interrupters) do
      result[hotkey] = cmp.mapping({
        c = function(fallback)
          if cmp.visible() then
            cmp.abort()
          end
          fallback()
        end
      })
    end
    return result
  end,
}
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Telescope ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.telescope = {
  d = function(x) return 'Telescope: ' .. x end,
  builtin = function()
    local d = M.telescope.d
    local function tfuz()
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end
    return {
      { '<leader>fp', require('telescope.builtin').builtin,              desc = d('Pickers') },
      { '<leader>fo', require('telescope.builtin').find_files,           desc = d('Find Files') },
      { '<leader>fb', require('telescope.builtin').buffers,              desc = d('Buffers') },
      { '<leader>fg', require('telescope.builtin').live_grep,            desc = d('Live Grep') },
      { '<leader>f/', tfuz,                                              desc = d('Buffer Fuzzy Find') },
      { '<leader>fm', require('telescope.builtin').marks,                desc = d('Marks') },
      { '<leader>fh', require('telescope.builtin').help_tags,            desc = d('Help') },
      { '<leader>fk', require('telescope.builtin').keymaps,              desc = d('Keymaps') },
      { '<leader>fs', require('telescope.builtin').lsp_document_symbols, desc = d('LSP Document Symbols') },
      {
        '<leader>fS',
        require('telescope.builtin').lsp_dynamic_workspace_symbols,
        desc = d('LSP Dynamic Workspace Symbols')
      },
      { '<leader>fr', require('telescope.builtin').lsp_references, desc = d('LSP References') },
      { '<leader>fd', require('telescope.builtin').diagnostics,    desc = d('LSP Diagnostics') },
    }
  end,
  zoxide = function()
    return {
      {
        '<leader>fj',
        function() require('telescope').extensions.zoxide.list() end,
        desc = M.telescope.d('Zoxide')
      }
    }
  end
}
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Harpoon ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --

function M.harpoon()
  local function d(x) return 'Harpoon: ' .. x end
  local function get_num_mappings()
    local res = {}
    for i = 1, 9 do
      res[i] = {
        '<leader>h' .. tostring(i),
        function() require('harpoon.ui').nav_file(i) end,
        desc = d('File #' .. tostring(i))
      }
    end
    return res
  end
  return {
    { '<leader>ha', function() require('harpoon.mark').add_file() end,        desc = d('Add File') },
    { '<leader>hl', function() require('harpoon.ui').toggle_quick_menu() end, desc = d('List Files') },
    { '<leader>hp', function() require('harpoon.ui').nav_prev() end,          desc = d('Prev File') },
    { '<leader>hn', function() require('harpoon.ui').nav_next() end,          desc = d('Next File') },
    unpack(get_num_mappings()),
  }
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
    }, {}),
    -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
    -- next two behave ~ the same: inner = rhs, outer = entire line
    e = ts({
      a = { '@assignment.outer' },
      i = { '@assignment.rhs' },
    }),
    r = ts({
      a = { '@return.outer' },
      i = { '@return.inner' },
    }),
    -- ~~~~~~~~~~~~~~~~~~~~~ misc ~~~~~~~~~~~~~~~~~~~~~~ --
    s = ts({ -- both literals and definition
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
  local function d(x) return 'UndoTree: ' .. x end
  return {
    {
      '<leader>u',
      '<cmd>UndotreeToggle<cr>',
      desc = d('Toggle'),
    }
  }
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TreeSitter ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.treesitter = {
  inc_selection = {
    init_selection = '<c-space>',
    node_incremental = '<c-space>',
    scope_incremental = false,
    node_decremental = '<bs>',
  },
  textobj_swap  = {
    swap_next = { ['<a-l>'] = '@parameter.inner' },
    swap_previous = { ['<a-h>'] = '@parameter.inner' },
  }
}
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GitSigns ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
function M.gitsigns(buffer)
  local gs = package.loaded.gitsigns
  local function ss(mode, l, r, desc)
    s(mode, l, r, { buffer = buffer, desc = 'GitSigns: ' .. desc })
  end
  ss('n', ']h', gs.next_hunk, 'Next Hunk')
  ss('n', '[h', gs.prev_hunk, 'Prev Hunk')
  ss({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<cr>', 'Stage Hunk')
  ss({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<cr>', 'Reset Hunk')
  ss('n', '<leader>gS', gs.stage_buffer, 'Stage Buffer')
  ss('n', '<leader>gR', gs.reset_buffer, 'Reset Buffer')
  ss('n', '<leader>gu', gs.undo_stage_hunk, 'Undo Stage Hunk')
  ss('n', '<leader>gp', gs.preview_hunk, 'Preview Hunk')
  ss('n', '<leader>gb', function() gs.blame_line({ full = true }) end, 'Blame Line')
  ss('n', '<leader>gd', gs.diffthis, 'Diff This')
  ss('n', '<leader>gD', function() gs.diffthis('~') end, 'Diff This ~')
  ss({ 'o', 'x' }, 'ih', ':<c-u>Gitsigns select_hunk<cr>', 'Select Hunk')
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ HaskellTools ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
function M.haskell_tools()
  local function d(x) return 'Haskell Tools: ' .. x end
  local ht = require('haskell-tools')
  return {
    main = function(buf)
      s('n', '<leader>hrp', ht.repl.toggle, { buffer = buf, desc = d('Toggle Package REPL') })
      s('n', '<leader>hrb',
        function() ht.repl.toggle(vim.api.nvim_buf_get_name(0)) end, { buffer = buf, desc = d('Toggle Buffer REPL') })
      s('n', '<leader>hrq', ht.repl.quit, { buffer = buf, desc = d('Quit REPL') })
    end,
    lsp = function(buf)
      s('n', '<leader>hh', ht.hoogle.hoogle_signature, { buffer = buf, desc = d('Show Hoogle Signature') })
      s('n', '<leader>he', ht.lsp.buf_eval_all, { buffer = buf, desc = d('Evaluate All') })
    end
  }
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Readline ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.readline = {
  { mode = '!', '<c-d>', '<delete>' },
  { mode = '!', '<c-k>', function() require('readline').kill_line() end },
  { mode = '!', '<a-d>', function() require('readline').kill_word() end },
  { mode = '!', '<c-b>', '<left>' },
  { mode = 'i', '<c-f>', '<right>' },
  { mode = '!', '<a-b>', function() require('readline').backward_word() end },
  { mode = '!', '<a-f>', function() require('readline').forward_word() end },
  { mode = '!', '<c-a>', function() require('readline').beginning_of_line() end },
  { mode = 'i', '<c-e>', function() require('readline').end_of_line() end },
}
return M
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
