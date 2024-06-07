{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    lenovo-legion
  ];

  boot = {
    initrd.kernelModules = ["nvidia"];
    extraModulePackages = [
      config.boot.kernelPackages.lenovo-legion-module
      config.boot.kernelPackages.nvidia_x11
    ];
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      prime = {
        intelBusId = "PCI:00:02:0";
        nvidiaBusId = "PCI:01:00:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
      nvidiaSettings = true;
    };
    opengl.enable = true; # just in case, should be enabled by sway module
  };

  # doesn't support ll7g9, keep just in case
  services.hardware.openrgb.enable = true;
}
