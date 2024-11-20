_: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        memtest86.enable = true;
        # edk2-uefi-shell.enable = true; # wait for 24.11 to release
        netbootxyz.enable = true;
      };
      efi.canTouchEfiVariables = true;
    };
    # silent boot
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = ["quiet" "udev.log_level=3"];
  };
}
