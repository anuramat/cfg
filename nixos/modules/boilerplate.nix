# - sane defaults
# - user-specific stuff from user.nix
{ ... }:
let
  user = import ../user.nix;
in
{
  documentation.man.generateCaches = true; # apropos
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config = {
    allowUnfree = true;
  };
  system =
    {
      # backup the configuration.nix to /run/current-system/configuration.nix
      copySystemConfiguration = true;
    };
  time.timeZone = user.timezone;
  i18n.defaultLocale = user.defaultLocale;
  system.stateVersion = user.stateVersion;
  networking.hostName = user.hostname;
  xdg.mime.defaultApplications = import ../mime.nix;
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
      # "input" # le unsecure, used by waybar-keyboard-state # XXX
      "dialout" # serial ports
      "networkmanager" # take a guess
    ];
  };
}
