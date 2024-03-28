local button_handlers = {
  new_file = function()
    vim.cmd('enew')
  end,
  obsidian_today = function()
    vim.cmd('ObsidianToday')
  end,
  obsidian_new = function()
    vim.cmd('ObsidianNew')
  end,
  configs = function()
    require('telescope.builtin').find_files({ cwd = '~/cfg/config/nvim' })
  end,
  find = function()
    vim.cmd('Telescope find_files')
  end,
  jump = function()
    vim.cmd('Telescope zoxide list')
  end,
}

local headers = {
  info = function()
    local datetime = os.date(' %d-%m-%Y   %H:%M:%S')
    local version = vim.version()
    local nvim_version_info = ' ' .. version.major .. '.' .. version.minor .. '.' .. version.patch
    return datetime .. '   ' .. nvim_version_info
  end,
}

local function make_button(name, func)
  local first = string.sub(name, 1, 1)
  return {
    type = 'button',
    val = string.sub(name, 2),
    on_press = func,
    opts = {
      keymap = { 'n', string.lower(first), func },
      cursor = 1,
      position = 'right',
      shortcut = '[' .. string.upper(first) .. ']',
      hl_shortcut = 'AlphaShortcut',
      hl = 'AlphaButtons',
      align_shortcut = 'left',
    },
  }
end

return {
  lazy = false,
  'goolord/alpha-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = function()
    local logo = {
      '            :h-                                  Nhy`               ',
      '           -mh.                           h.    `Ndho               ',
      '           hmh+                          oNm.   oNdhh               ',
      '          `Nmhd`                        /NNmd  /NNhhd               ',
      '          -NNhhy                      `hMNmmm`+NNdhhh               ',
      '          .NNmhhs              ```....`..-:/./mNdhhh+               ',
      '           mNNdhhh-     `.-::///+++////++//:--.`-/sd`               ',
      '           oNNNdhhdo..://++//++++++/+++//++///++/-.`                ',
      '      y.   `mNNNmhhhdy+/++++//+/////++//+++///++////-` `/oos:       ',
      ' .    Nmy:  :NNNNmhhhhdy+/++/+++///:.....--:////+++///:.`:s+        ',
      ' h-   dNmNmy oNNNNNdhhhhy:/+/+++/-         ---:/+++//++//.`         ',
      ' hd+` -NNNy`./dNNNNNhhhh+-://///    -+oo:`  ::-:+////++///:`        ',
      ' /Nmhs+oss-:++/dNNNmhho:--::///    /mmmmmo  ../-///++///////.       ',
      '  oNNdhhhhhhhs//osso/:---:::///    /yyyyso  ..o+-//////////:/.      ',
      '   /mNNNmdhhhh/://+///::://////     -:::- ..+sy+:////////::/:/.     ',
      '     /hNNNdhhs--:/+++////++/////.      ..-/yhhs-/////////::/::/`    ',
      '       .ooo+/-::::/+///////++++//-/ossyyhhhhs/:///////:::/::::/:    ',
      '       -///:::::::////++///+++/////:/+ooo+/::///////.::://::---+`   ',
      '       /////+//++++/////+////-..//////////::-:::--`.:///:---:::/:   ',
      '       //+++//++++++////+++///::--                 .::::-------::   ',
      '       :/++++///////////++++//////.                -:/:----::../-   ',
      '       -/++++//++///+//////////////               .::::---:::-.+`   ',
      '       `////////////////////////////:.            --::-----...-/    ',
      '        -///://////////////////////::::-..      :-:-:-..-::.`.+`    ',
      '         :/://///:///::://::://::::::/:::::::-:---::-.-....``/- -   ',
      '           ::::://::://::::::::::::::----------..-:....`.../- -+oo/ ',
      '            -/:::-:::::---://:-::-::::----::---.-.......`-/.      ``',
      '           s-`::--:::------:////----:---.-:::...-.....`./:          ',
      '          yMNy.`::-.--::..-dmmhhhs-..-.-.......`.....-/:`           ',
      '         oMNNNh. `-::--...:NNNdhhh/.--.`..``.......:/-              ',
      '        :dy+:`      .-::-..NNNhhd+``..`...````.-::-`                ',
      '                        .-:mNdhh:.......--::::-`                    ',
      '                           yNh/..------..`                          ',
      '                                                                    ',
    }

    local layout = {
      make_button('scratch', button_handlers.new_file),
      make_button('note', button_handlers.obsidian_new),
      make_button('today', button_handlers.obsidian_today),
      make_button('preferences', button_handlers.configs),
      make_button('open', button_handlers.find),
      make_button('jump', button_handlers.find),
      { type = 'text', val = headers.info, opts = { position = 'center' } },
      { type = 'padding', val = 3 },
      { type = 'text', val = logo, opts = { position = 'center' } },
    }

    return { layout = layout }
  end,
}
