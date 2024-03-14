{ ... }:
let
  user = import ./user.nix;
in
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config = {
    allowUnfree = true;
  };
  system =
    {
      # backup the configuration.nix to /run/current-system/configuration.nix
      copySystemConfiguration = true;
    };
  time.timeZone = user.timezone; # WARN inverted
  i18n.defaultLocale = user.defaultLocale;
  system.stateVersion = user.stateVersion;
  networking.hostName = user.hostname;

  users.users.${user.username} = {
    description = user.fullname;
    isNormalUser = true;
    extraGroups = [
      "wheel" # root
      "video" # screen brightness
      "network" # wifi
      "docker" # docker
      "audio" # just in case (?)
      "syncthing" # just in case default syncthing settings are used
      "plugdev" # pluggable devices : required by zsa voyager
      "input" # le unsecure, used by waybar-keyboard-state
      "dialout" # serial ports
    ];
  };
}
