local o = vim.o
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Formatting ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
o.expandtab = true
o.formatoptions = "ro/qwjp"
o.shiftround = true
o.shiftwidth = 0
o.tabstop = 4
o.textwidth = 79
vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "go" },
  command = "setlocal noexpandtab",
})
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Theme ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
-- Colorscheme
if not pcall(vim.cmd.colorscheme, "dracula") then
  vim.cmd.colorscheme("habamax")
end
-- CodeLens style
local clhl = vim.api.nvim_get_hl(0, { name = 'LspCodeLens' })
clhl.underline = true
vim.api.nvim_set_hl(0, 'LspCodeLens', clhl)
-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Other visuals ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
o.cmdheight = 1 -- TODO change after fixing annoying message
o.display = "lastline,uhex"
o.laststatus = 3
o.list = true
o.listchars = "tab:│ ,extends:❯,precedes:❮,nbsp:␣,trail:·,lead:·"
o.matchtime = 1
o.number = true
o.relativenumber = true
o.scrolloff = 10
o.shortmess = "asWIcCF"
o.showbreak = "↪  ↪"
o.showmatch = true
o.showmode = false
o.signcolumn = "yes" 
o.termguicolors = true
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Misc ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
o.clipboard = "unnamedplus"
o.foldenable = false
o.foldmethod = "indent"
o.ignorecase = true
o.report = 0
o.completeopt = 'menuone,noselect'
o.smartcase = true
o.timeout = false
o.undofile = true  -- writebackup and swap already on
o.updatetime = 100 -- has influence on some plugins
o.virtualedit = "block"
o.wildoptions = "fuzzy,pum"
vim.opt.backupdir:remove(".") -- don't shit in your cwd
