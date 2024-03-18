{ ... }:
{
  # TODO why set nameservers twice?
  networking =
    {
      firewall = {
        enable = true;
        allowedTCPPorts = [ ];
        allowedUDPPorts = [ ];
      };
      networkmanager = {
        enable = true;
      };
      nameservers = [ "1.1.1.1" "1.0.0.1" ];
    };
  # uses DNSSEC and DNSoverTLS, might break on a different ns
  services.resolved = {
    enable = true;
    dnssec = "true";
    dnsovertls = "true";
    domains = [ "~." ]; # TODO what does this do?
    fallbackDns = [ "1.1.1.1" "1.0.0.1" ]; # TODO when is this used?
  };

  hardware.bluetooth =
    {
      enable = true;
      powerOnBoot = true;
    };
  services.blueman.enable = true; # bluetooth gui
}
