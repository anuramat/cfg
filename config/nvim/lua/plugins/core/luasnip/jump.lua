--- Jump to a snippet field
--- Fallback is called if jump isn't possible
--- @param jump_size integer Relative position of the target field
--- @return function mapping
return function(jump_size)
  local luasnip = require('luasnip')
  return function(fallback)
    if luasnip.locally_jumpable(jump_size) then
      luasnip.jump(jump_size)
    else
      fallback()
    end
  end
end
