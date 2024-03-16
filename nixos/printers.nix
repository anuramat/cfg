{}:
{
  services = {
    # Enable CUPS to print documents, available @ http://localhost:631/
    printing = {
      enable = true;
      # drivers = [ YOUR_DRIVER ];
    };
    # Implementation for Multicast DNS aka Zeroconf aka Apple Rendezvous aka Apple Bonjour
    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true; # Open udp 5353 for network devices discovery
    };
  };
}
