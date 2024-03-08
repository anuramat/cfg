vim.o.winblend = 20 -- to show off blur
vim.g.border = 'solid' -- we already have shadows and blur
vim.o.scrolloff = 1 -- otherwise cursorline leaves a trail
vim.g.neovide_cursor_animation_length = 0.03 -- slightly faster cursor animation
-- vim.g.neovide_transparency = 0.9 -- such a bad idea
vim.g.neovide_scroll_animation_far_lines = 0 -- when scrolling more then a screen, animate this many lines

vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 4
vim.g.neovide_light_radius = 10
