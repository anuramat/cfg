{
  pkgs,
  lib,
  ...
}: {
  programs = {
    starship = {
      enable = true;
      presets = ["plain-text-symbols"];
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

    direnv = {
      enable = true;
      silent = true;
      direnvrcExtra = ''
        use flake
      '';
    };

    fzf = {
      keybindings = true;
      fuzzyCompletion = true;
    };

    bash = {
      shellAliases = lib.mkForce {};
      promptInit = "";
      enableLsColors = false;
      interactiveShellInit = ''
        source ${./osc.sh}
        source ${./history.sh}
        source ${pkgs.bash-preexec}/share/bash/bash-preexec.sh
      '';
    };
  };

  environment = {
    localBinInPath = true;
    shellAliases = lib.mkForce {};
  };
}
# vim: fdl=3

