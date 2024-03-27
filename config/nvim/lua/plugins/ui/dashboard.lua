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
    local function info()
      local datetime = os.date(' %d-%m-%Y   %H:%M:%S')
      local version = vim.version()
      local nvim_version_info = ' ' .. version.major .. '.' .. version.minor .. '.' .. version.patch
      return datetime .. '   ' .. nvim_version_info
    end
    local layout = {
      { type = 'padding', val = 3 },
      { type = 'text', val = info, opts = { position = 'center' } },
      { type = 'padding', val = 3 },
      { type = 'text', val = logo, opts = { position = 'center' } },
    }

    return { layout = layout }
  end,
}
