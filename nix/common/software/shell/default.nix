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
      promptInit = "# placeholder: bash.promptInit";
      enableLsColors = false;
      shellInit = "# placeholder: bash.shellInit";
      loginShellInit = "# placeholder: bash.loginShellInit";
      interactiveShellInit = ''
        # bash.interactiveShellInit {{{1
        source ${./profile.sh}
        source ${./osc.sh}
        source ${./history.sh}
        source ${pkgs.bash-preexec}/share/bash/bash-preexec.sh
        # end }}}
      '';
    };
  };

  # exec order:
  # /etc/profile: bash init, sh init, bash login, sh login, /etc/profile.local, /etc/bashrc
  # /etc/bashrc: /etc/profile, bash inter, bash prompt, software, sh inter, /etc/bashrc.local

  environment = {
    localBinInPath = true; # TODO change
    shellAliases = lib.mkForce {};
    shellInit = "# placeholder: environment.shellInit";
    loginShellInit = ''
      # placeholder: environment.loginShellInit {{{1
      source ${./profile.sh}
      source ${./sway_autostart.sh}
      # end }}}
    '';
    interactiveShellInit = "# placeholder: environment.interactiveShellInit";
    extraInit = "# placeholder: environment.extraInit";
  };
}
# vim: fdl=3

