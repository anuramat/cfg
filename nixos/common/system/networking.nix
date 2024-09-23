{user, ...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true; # bluetooth gui

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [22];
      allowedUDPPorts = [];
    };
    networkmanager = {
      enable = true;
    };
  };

  services = {
    fail2ban.enable = true; # intrusion prevention
    openssh = {
      enable = true;
      ports = [22];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = ["anuramat"];
      };
    };
  };
  users.users.${user.username}.openssh.authorizedKeys.keys = [user.key];
}
