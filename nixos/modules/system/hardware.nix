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

  # these are stolen from the wiki https://nixos.wiki/wiki/Nvidia
  # Enable OpenGL TODO why?
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  # Load nvidia driver for Xorg and Wayland TODO why
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    prime = {
      intelBusId = "PCI:00:02:0";
      nvidiaBusId = "PCI:01:00:0";
    };
    nvidiaSettings = true;
  };
}
