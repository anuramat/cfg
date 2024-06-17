{config, ...}: {
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
  # Virtual webcam
  kernelModules = ["v4l2loopback"];
  # TODO ?? no fucking idea what this one does, probably doesn't work without it
  # TODO the obs guide has something slightly different?? https://nixos.wiki/wiki/OBS_Studio
  extraModulePackages = with config.boot.kernelPackages; [v4l2loopback.out];
  extraModprobeConfig = ''
    # exclusive_caps: compatibility thing
    # https://github.com/umlaeute/v4l2loopback
    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  '';
}
