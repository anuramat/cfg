# > man 5 configuration.nix
# > nixos help
{overlays, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./modules
  ];
  nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0"];
  nixpkgs.overlays = overlays;
  # home-manager.users.${user.username} = {
  #   home.stateVersion = user.stateVersion;
  # };
}
