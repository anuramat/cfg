# - sane defaults
# - user-specific stuff from user.nix
{user, ...}: {
  documentation.man.generateCaches = true; # apropos
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://devenv.cachix.org"
      "https://nixpkgs-python.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  }; # kinda imperative
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
