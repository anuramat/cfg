_: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # silent boot
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = ["quiet" "udev.log_level=3"];
  };
}
