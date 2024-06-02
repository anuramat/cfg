_: {
  # ZSA Voyager
  services.udev.extraRules = ''
    # Rules for Oryx web flashing and live training
    KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"
    # Keymapp Flashing rules for the Voyager
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu"
  '';
  # Flipper Zero
  hardware.flipperzero.enable = true;
  # Removable media
  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };
  programs.gnome-disks.enable = true;
}
