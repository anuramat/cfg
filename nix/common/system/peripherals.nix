{
  user,
  pkgs,
  unstable,
  ...
}:
{
  hardware = {
    # Flipper Zero
    flipperzero.enable = true;
    # Generic RGB software
    # Razer
    openrazer = {
      users = [ user.username ];
      enable = true;
    };
  };
  environment.systemPackages = [
    unstable.keymapp # ZSA keyboard thing
    pkgs.polychromatic # openrazer frontend
    pkgs.rpi-imager # raspbery pi
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
  };
}
