{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    lenovo-legion
  ];

  boot = {
    extraModulePackages = [
      config.boot.kernelPackages.lenovo-legion-module
    ];
  };

  services = {
    # ssd
    fstrim.enable = true;
    # doesn't support ll7g9, keep just in case
    hardware.openrgb.enable = true;
    # proprietary drivers
    xserver = {
      dpi = 236;
    };
  };

  services.tlp.settings = {
    # turn on battery charge threshold
    # `tlp fullcharge` to charge to 100% once
    START_CHARGE_THRESH_BAT0 = 0; # dummy value
    STOP_CHARGE_THRESH_BAT0 = 1;
  };

  # # nvidia (off because sway)
  # # {{{1
  # services.xserver.videoDrivers = ["nvidia"];
  # hardware = {
  #   nvidia = {
  #     modesetting.enable = true; # wiki says this is required
  #     # these two are experimental
  #     powerManagement = {
  #       enable = true; # saves entire vram to /tmp/ instead of the bare minimum
  #       finegrained = true; # turns off gpu when not in use
  #     };
  #     prime = {
  #       intelBusId = "PCI:00:02:0";
  #       nvidiaBusId = "PCI:01:00:0";
  #       # prime offloading
  #       offload = {
  #         enable = true;
  #         enableOffloadCmd = true; # `nvidia-offload`
  #       };
  #     };
  #     nvidiaSettings = true;
  #   };
  #   opengl = {
  #     extraPackages = with pkgs; [
  #       vaapiVdpau # no fucking idea what this does
  #     ];
  #     enable = true; # just in case, should be enabled by sway module
  #     driSupport = true; # on by default but whatever
  #     driSupport32Bit = true; # might be required for wine? might break on nouveau
  #   };
  # };
  # # }}}
}
# vim: fdm=marker fdl=0
