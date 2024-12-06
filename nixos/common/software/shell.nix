_: {
  programs.starship = {
    enable = true;
    presets = [ "plain-text-symbols" ];
    settings = {
      format = " $all$status$line_break$character";
      character = {
        success_symbol = "";
        error_symbol = "";
        vimcmd_symbol = "";
      };
      status = {
        disabled = false;
        style = "bold red";
        format = "[$status:$common_meaning$signal_name]($style)";
      };
      time = {
        disabled = false;
        format = "[$time]($style) ";
      };
    };
  };
}
