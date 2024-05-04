_: {
  programs.seahorse.enable = true; # gnome keyring frontend

  # virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;
  services = {
    gnome.gnome-keyring.enable = true; # security credential storage, exposed over dbus
    # syncthing = {
    #   enable = true;
    #   user = user.username;
    #   dataDir = "/home/${user.username}/Syncthing"; # parent directory for synchronised folders
    #   configDir = "/home/${user.username}/.config/syncthing"; # keys and settings
    #   databaseDir = "/home/${user.username}/.local/share/syncthing"; # database and logs
    #   # if unccomented, somehow use XDG variables
    # };
  };
}
