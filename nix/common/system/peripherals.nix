{
  user,
  pkgs,
  unstable,
  ...
}: {
  hardware = {
    # Flipper Zero
    flipperzero.enable = true;
    # Generic RGB software
    # Razer
    openrazer = {
      users = [user.username];
      enable = true;
    };
  };
  environment.systemPackages = [
    unstable.keymapp # ZSA keyboard thing
    pkgs.polychromatic # openrazer frontend
  ];
  # kmonad is apparently big and slow
  services = {
    # ZSA Voyager
    udev.extraRules = ''
      # Rules for Oryx web flashing and live training
      KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
      KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"
      # Keymapp Flashing rules for the Voyager
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu"
    '';
    hardware.openrgb.enable = true;
    keyd = {
      enable = true;
      keyboards = {
        laptop = {
          ids = [
            "048d:c997:193096a7" # ll7
          ];
          settings = {
            main = {
              a = "overloadt2(control, a, 128)";
              s = "overloadt2(shift, s, 128)";
              d = "overloadt2(alt, d, 128)";
              f = "overloadt2(meta, f, 128)";

              semicolon = "overloadt2(control, semicolon, 128)";
              l = "overloadt2(shift, l, 128)";
              k = "overloadt2(alt, k, 128)";
              j = "overloadt2(meta, j, 128)";

              # <https://github.com/rvaiya/keyd/issues/114>
              # sad.
              rightcontrol = "rightcontrol";
              rightshift = "rightshift";
              rightalt = "rightalt";
              rightmeta = "rightmeta";
            };
          };
        };
      };
    };
  };
}
