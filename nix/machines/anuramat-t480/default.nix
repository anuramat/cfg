{inputs, ...}: {
  system.stateVersion = "24.05";

  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
    ./hardware-configuration.nix
  ];

  networking.hostName = "anuramat-t480";

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
  ];

  boot = {
    # boot splashscreen
    plymouth = {
      enable = true;
      theme = "breeze"; # package is overridden to use a nixos logo
    };
    kernelModules = ["v4l2loopback"]; # virtual webcam
  };
}
