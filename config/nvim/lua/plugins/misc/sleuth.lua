-- Autodetect indentation settings
return {
  'tpope/vim-sleuth',
  event = { 'BufReadPre', 'BufNewFile' },
}
