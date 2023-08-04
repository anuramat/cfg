local u = require('utils')
local o = vim.o
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Formatting ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
o.expandtab = true
o.formatoptions = 'qwj' -- add 'ro/' to autoprepend comment leader
o.shiftround = true
o.shiftwidth = 0
o.tabstop = 2
o.textwidth = 119
-- Autoformat on save
local af_group = vim.api.nvim_create_augroup('LSPAutoformat', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = af_group,
  callback = function()
    local client = vim.lsp.get_active_clients()[1]
    if not (client and client.server_capabilities.documentFormattingProvider) then return end
    -- TODO figure out why this errors out on markdown:
    pcall(function() vim.lsp.buf.format({ async = false }) end)
  end,
})
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~ Highlight on yank ~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
local hl_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = hl_group,
  pattern = '*',
})
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Other visuals ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
vim.cmd.colorscheme('habamax')
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
u.style_codelens()
o.display = 'lastline,uhex'
o.fillchars = 'fold: ,foldopen:,foldsep: ,foldclose:'
o.laststatus = 3
o.list = true
o.listchars = 'tab:│ ,extends:❯,precedes:❮,nbsp:␣,trail:·,lead:·'
o.matchtime = 1
o.number = true
o.relativenumber = true
o.scrolloff = 10
o.shortmess = 'asWIcCF'
o.showbreak = '↪  ↪'
o.showmatch = true
o.showmode = false
o.signcolumn = 'yes'
o.termguicolors = true
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Folding ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
-- TODO turn on after hiding numbers and fixing alignment:
o.foldcolumn = '0'
o.foldenable = false
o.foldmethod = 'indent'
-- ufo magic start --
o.foldenable = true
o.foldlevel = 99
o.foldlevelstart = 99
-- ufo magic end --
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Misc ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
o.clipboard = 'unnamedplus'
o.completeopt = 'menuone,noselect'
o.ignorecase = true
o.report = 0
o.smartcase = true
o.timeout = false
o.undofile = true  -- writebackup and swap already on
o.updatetime = 100 -- has influence on some plugins
o.virtualedit = 'block'
o.wildoptions = 'fuzzy,pum'
vim.opt.backupdir:remove('.') -- don't shit in your cwd
