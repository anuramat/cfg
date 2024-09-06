_: {
  # removable media stuff
  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };
  # udisks2 frontend
  programs.gnome-disks.enable = true;

  # realtime kit, hands out realtime priority to user processes
  security.rtkit.enable = true;

  virtualisation = {
    # common container config files in /etc/containers
    containers.enable = true;
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # security credential storage, exposed over dbus
  services.gnome.gnome-keyring.enable = true;
  # gnome keyring frontend
  programs.seahorse.enable = true;
  # auto setup environment when opening a project folder
  programs.direnv.enable = true;
}
