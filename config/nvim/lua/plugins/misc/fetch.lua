-- features:
-- - `nvim $filename:$line` opens the file on the line $line
-- - `nvim $filename +/pattern` searches on open
-- TODO check if this breaks gf gF
return {
  lazy = false,
  'wsdjeg/vim-fetch',
}
