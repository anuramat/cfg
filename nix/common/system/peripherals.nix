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
            "0001:0001:a38e6885" # t480
          ];
          settings = {
            main = {
              # def lettermod(letter, mod, x, y):
              #     if last symbol was triggered at t: (now - x < t): return letter
              #     if key is held for longer than y OR there was a full tap inside the key hold: return mod
              #     return letter
              a = "lettermod(control, a, 128, 256)";
              s = "lettermod(shift, s, 128, 256)";
              d = "lettermod(alt, d, 128, 256)";
              f = "lettermod(meta, f, 128, 256)";

              # mapped to left mods too but it sholdn't be a problem, since
              # most of the time apps don't care
              semicolon = "lettermod(control, semicolon, 128, 256)";
              l = "lettermod(shift, l, 128, 256)";
              k = "lettermod(alt, k, 128, 256)";
              j = "lettermod(meta, j, 128, 256)";

              capslock = "noop";

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
