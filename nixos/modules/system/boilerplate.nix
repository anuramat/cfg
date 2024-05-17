# - sane defaults
# - user-specific stuff from user.nix
{user, ...}: {
  documentation.man.generateCaches = true; # apropos
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root" user.username];
  };
  nixpkgs.config = {
    allowUnfree = true;
  };
  time.timeZone = user.timezone;
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
      "input" # le unsecure, used by waybar-keyboard-state for caps/scroll/num lock state
      # also way-displays uses input group to get lid state
      "dialout" # serial ports
      "networkmanager"
      "scanner"
      "lp" # printers
    ];
  };
}
