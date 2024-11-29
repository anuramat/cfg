{user, ...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true; # bluetooth gui

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 # SSH
        8080
        8888
        9000
        9001
      ];
      allowedUDPPorts = [];
    };
    networkmanager = {
      enable = true;
    };
  };

  services = {
    fail2ban.enable = true; # intrusion prevention
    tailscale.enable = true;
    openssh = {
      enable = true;
      ports = [22];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [user.username];
      };
    };
  };
}
