{
  pkgs,
  config,
  lib,
  ...
}: {
  services.logind.extraConfig = ''
    HandlePowerKey=hybrid-sleep
    HandlePowerKeyLongPress=ignore
    HandleSuspendKey=suspend
    HandleHibernateKey=suspend
    HandleLidSwitch=suspend
    HandleLidSwitchDocked=ignore
    HandleLidSwitchExternalPower=ignore
  '';
  services = {
    thermald.enable = true; # cooling
    tlp.enable = true; # voltage, wifi/bluetooth cli switches
    upower.enable = true; # suspend on low battery
  };
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

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    prime = {
      intelBusId = "PCI:00:02:0";
      nvidiaBusId = "PCI:01:00:0";
    };
  };
}
