_: {
  # TODO why set nameservers twice?
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
    networkmanager = {
      enable = true;
      # wifi ignores resolved or does it... FIXME figure out if dns is ok
    };

    nameservers = ["1.1.1.1" "1.0.0.1"];
  };
  # uses DNSSEC and DNSoverTLS, might break on a different ns
  services.resolved = {
    enable = true;
    dnssec = "true";
    dnsovertls = "true";
    domains = ["~."]; # TODO what does this do?
    fallbackDns = ["1.1.1.1" "1.0.0.1"];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true; # bluetooth gui
}
