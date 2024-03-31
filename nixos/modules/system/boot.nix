{...}: {
  boot = {
    # silent boot
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = ["quiet" "udev.log_level=3"];
    # boot splashscreen
    plymouth = {
      enable = true;
      theme = "breeze"; # package is overridden to use a nixos logo
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelModules = ["v4l2loopback"]; # virtual webcam
  };
}
