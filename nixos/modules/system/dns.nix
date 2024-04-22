_: {
  # # TODO why set nameservers twice?
  # networking = {
  #   nameservers = ["1.1.1.1" "1.0.0.1"];
  # };
  # # uses DNSSEC and DNSoverTLS, might break on a different ns
  # services.resolved = {
  #   enable = true;
  #   dnssec = "true";
  #   dnsovertls = "true";
  #   domains = ["~."]; # TODO what does this do?
  #   fallbackDns = ["1.1.1.1" "1.0.0.1"];
  # };
}
