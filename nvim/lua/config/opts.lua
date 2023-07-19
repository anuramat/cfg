local o = vim.o
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Formatting ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
o.expandtab = true
o.formatoptions = "ro/qwjp"
o.shiftround = true
o.shiftwidth = 0
o.tabstop = 4
o.textwidth = 79
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Visuals ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
if not pcall(vim.cmd.colorscheme, "dracula") then
  vim.cmd.colorscheme("habamax")
end
o.cmdheight = 1 -- TODO change after fixing annoying message
o.colorcolumn = "80"
o.display = "lastline,uhex"
o.laststatus = 3
o.list = true
o.listchars = "tab:│·,extends:❯,precedes:❮,nbsp:␣,trail:·,lead:·"
o.matchtime = 1
o.number = true
o.relativenumber = true
o.scrolloff = 10
o.shortmess = "asWIcCF"
o.showbreak = "↪  ↪"
o.showmatch = true
o.showmode = false
o.signcolumn = "number"
o.termguicolors = true
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Misc ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
o.clipboard = "unnamedplus"
o.foldenable = false
o.foldmethod = "indent"
o.ignorecase = true
o.report = 0
o.smartcase = true
o.timeout = false
o.undofile = true             -- writebackup and swap already on
o.updatetime = 333            -- has influence on some plugins
o.wildoptions = "fuzzy,pum"
vim.opt.backupdir:remove(".") -- don't shit in your cwd
