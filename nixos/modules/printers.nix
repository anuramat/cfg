{ pkgs, ... }:
{
  # scanning - `scanimage`
  # printing - http://localhost:631/
  # list printers - `lpstat -p`
  # list printer jobs - `lpstat`
  # cancel job - `cancel 1`
  # printing - `system-config-printer`

  # https://nixos.wiki/wiki/Printing
  # https://nixos.wiki/wiki/Scanners
  services = {
    # Enable CUPS to print documents, available @ http://localhost:631/
    printing = {
      enable = true;
      drivers = [ ];
    };
    # Implementation for Multicast DNS aka Zeroconf aka Apple Rendezvous aka Apple Bonjour
    # network printers autodiscovery
    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true; # Open udp 5353 for network devices discovery
    };
  };
  hardware.printers = { };
  hardware.sane = {
    enable = true;
    extraBackends = [ ];
  };
}
