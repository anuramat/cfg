local M = {}
local utils = require('utils')
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Intro ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
-- For the most part mappings look like this:
-- <Leader><ModuleMnemonic><FunctionMnemonic>
-- Closely integrated mappings do not (have to) conform to this "rule".
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Helpers ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
local s = vim.keymap.set
local function nmap(l, r, d) s('n', l, r, { silent = true, desc = d }) end
local function vmap(l, r, d) s('v', l, r, { silent = true, desc = d }) end
local function imap(l, r, d) s('i', l, r, { silent = true, desc = d }) end
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Built-in ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
function M.main()
  vim.g.mapleader = ' '
  s({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
  s('t', '<esc>', '<c-\\><c-n>', { silent = true })
  -- Buffer
  nmap('<leader>bn', ':bn<cr>', 'Next Buffer')
  nmap('<leader>bp', ':bp<cr>', 'Previous Buffer')
  nmap('<leader>bd', ':bd<cr>', 'Delete Buffer')
  nmap('<leader>bD', ':bd!<cr>', 'Delete Buffer (forced)')
  -- Quickfix
  nmap('<leader>qc', ':ccl<cr>', 'Close Quickfix')
  nmap('<leader>qo', ':cope<cr>', 'Open Quickfix')
  nmap('<leader>qp', ':cn<cr>', 'Prev Quickfix')
  nmap('<leader>qn', ':cp<cr>', 'Next Quickfix')
  nmap('<leader>qf', ':cnew<cr>', 'Prev Quickfix List')
  nmap('<leader>qb', ':col<cr>', 'Next Quickfix List')
  nmap('<leader>qh', ':chi<cr>', 'Quickfix History')
  -- Scroll with centered cursor
  nmap('<c-u>', '<c-u>zz0', 'Scroll Up')
  nmap('<c-d>', '<c-d>zz0', 'Scroll Down')
  nmap('<c-b>', '<c-b>zz0', 'Page Up')
  nmap('<c-f>', '<c-f>zz0', 'Page Down')
  -- Move lines (I still don't get why it's -2)
  nmap('<a-j>', '<cmd>m .+1<cr>==', 'Move Line Down')
  nmap('<a-k>', '<cmd>m .-2<cr>==', 'Move Line Up')
  vmap('<a-j>', ":m '>+1<cr>gv=gv", 'Move Line Down')
  vmap('<a-k>', ":m '<-2<cr>gv=gv", 'Move Line Up')
  imap('<a-j>', '<esc><cmd>m .+1<cr>==gi', 'Move Line Down')
  imap('<a-k>', '<esc><cmd>m .-2<cr>==gi', 'Move Line Up')
  -- Header
  local header = function() require('config.macros').create_comment_header('~', false) end
  nmap('<leader>#', header, 'Create Comment Header')
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ LSP ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.lsp = function(buffer)
  local n = function(keys, func, desc)
    s('n', keys, func, { buffer = buffer, desc = 'LSP: ' .. desc })
  end

  local list_workspace_folders = function()
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
M.trouble = function()
  local d = function(x) return 'Trouble: ' .. x end
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
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Flash ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.flash = function()
  local d = function(x) return 'Flash: ' .. x end
  return {
    { 's', mode = { 'n', },     function() require('flash').jump() end,       desc = d('Jump') },
    { 'S', mode = { 'n', 'o' }, function() require('flash').treesitter() end, desc = d('Treesitter') },
    { 'r', mode = { 'o' },      function() require('flash').remote() end,     desc = d('Remote') },
    't', 'T', 'f', 'F'
  }
end
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ TreeSJ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.treesj = function()
  return { {
    '<leader>j',
    mode = { 'n' },
    function()
      require('treesj').toggle()
    end,
    desc = 'TreeSJ: Toggle'
  } }
end
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ CMP ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.cmp = {
  -- for the most part using cmp defaults
  -- trying to match default vim ins/cmdline-completion hotkeys
  c = function()
    local cmp = require('cmp')
    return {
      -- So that completion doesn't block the cmdline window
      ['C-f'] =
          function()
            if cmp.visible() then
              cmp.abort()
            end
            utils.press('C-f')
          end
      ,
      ['<C-n>'] = cmp.config.disable,
      ['<C-p>'] = cmp.config.disable,
    }
  end,
  i = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    return {
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    }
  end
}
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Telescope ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.telescope = {
  d = function(x) return 'Telescope: ' .. x end,
  builtin = function()
    local d = M.telescope.d
    local tfuz = function()
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
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Harpoon ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.harpoon = function()
  local d = function(x) return 'Harpoon: ' .. x end
  local get_num_mappings = function()
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
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Surround ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.surround = {
  -- using defaults
}
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Comment ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.comment = {
  toggler = {
    line = '<leader>cc',
    block = '<leader>CC',
  },
  opleader = {
    line = '<leader>c',
    block = '<leader>C',
  },
  extra = {
    above = '<leader>cO',
    below = '<leader>co',
    eol = '<leader>cA',
  },
}
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ mini.ai ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.miniai = function()
  local ai = require('mini.ai')
  return { -- TODO more textobjects
    o = ai.gen_spec.treesitter({
      a = { '@block.outer', '@conditional.outer', '@loop.outer' },
      i = { '@block.inner', '@conditional.inner', '@loop.inner' },
    }, {}),
    f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
    c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
  }
end
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ UndoTree ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.undotree = function()
  local function d(x) return 'UndoTree: ' .. x end
  return {
    {
      '<leader>u',
      '<cmd>UndotreeToggle<cr>',
      desc = d('Toggle'),
    }
  }
end
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Treesitter ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
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
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ GitSigns ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.gitsigns = function(buffer)
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
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ haskell-tools ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
M.haskell_tools = function()
  local d = function(x) return 'Haskell Tools: ' .. x end
  local ht = require('haskell-tools')
  return {
    main = function(buf)
      s('n', '<leader>hrp', ht.repl.toggle, { buffer = buf, desc = d('Toggle Package REPL') })
      s('n', '<leader>hrb',
        function() ht.repl.toggle(vim.api.nvim_buf_get_name(0)) end, { buffer = buf, d('Toggle Buffer REPL') })
      s('n', '<leader>hrq', ht.repl.quit, { buffer = buf, d('Quit REPL') })
    end,
    lsp = function(buf)
      s('n', '<leader>hh', ht.hoogle.hoogle_signature, { buffer = buf, d('Show Hoogle Signature') })
      s('n', '<leader>he', ht.lsp.buf_eval_all, { buffer = buf, d('Evaluate All') })
    end
  }
end
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
return M
