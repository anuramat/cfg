{user, ...}: {
  # TODO restic backups

  programs.seahorse.enable = true; # gnome keyring frontend

  virtualisation.docker.enable = true;
  services = {
    gnome.gnome-keyring.enable = true; # security credential storage, exposed over dbus
    hoogle = {
    enable = true;
    };
    syncthing = {
      enable = true;
      user = user.username;
      dataDir = "/home/${user.username}"; # parent directory for synchronised folders
      configDir = "/home/${user.username}/.config/syncthing"; # keys and settings
      databaseDir = "/home/${user.username}/.local/share/syncthing"; # database and logs
      # TODO somehow use XDG variables
    };
  };
}
