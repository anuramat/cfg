{
  pkgs,
  config,
  inputs,
  ...
}: {
  system.stateVersion = "24.05";
  networking.hostName = "anuramat-ll7";

  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    lenovo-legion
  ];

  boot = {
    extraModulePackages = [
      config.boot.kernelPackages.lenovo-legion-module
    ];
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 128 * 1024;
    }
  ];

  services = {
    # ssd
    fstrim.enable = true;
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

  # # intel
  # hardware.cpu.intel.updateMicrocode = true;

  # nvidia
  # {{{1
  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
    nvidia = {
      open = true; # recommended on turing+
      modesetting.enable = true; # wiki says this is required
      # these two are experimental
      powerManagement = {
        enable = true; # saves entire vram to /tmp/ instead of the bare minimum
        finegrained = true; # turns off gpu when not in use
      };
      prime = {
        intelBusId = "PCI:00:02:0";
        nvidiaBusId = "PCI:01:00:0";
        # prime offloading
        offload = {
          enable = true;
          enableOffloadCmd = true; # `nvidia-offload`
        };
      };
      nvidiaSettings = true;
    };
    graphics = {
      extraPackages = with pkgs; [
        vaapiVdpau # no fucking idea what this does
      ];
      # no idea what these do anymore
      enable = true;
      enable32Bit = true;
    };
  };
  # }}}
}
# vim: fdm=marker fdl=0

