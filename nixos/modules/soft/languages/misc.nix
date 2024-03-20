{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    jq # json processor
    yq # basic yaml, json, xml, csv, toml processor
    bats # Bash testing
  ];
}
