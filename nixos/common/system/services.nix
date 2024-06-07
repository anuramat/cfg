_: {
  programs.seahorse.enable = true; # gnome keyring frontend

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
  services = {
    gnome.gnome-keyring.enable = true; # security credential storage, exposed over dbus
  };
}
