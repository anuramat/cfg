{ ... }: {
  # TODO restic backups
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  virtualisation.docker.enable = true;
  services.syncthing =
    {
      enable = true;
      user = user.username;
      dataDir = "/home/${user.username}"; # parent directory for synchronised folders
      configDir = "/home/${user.username}/.config/syncthing"; # keys and settings
      databaseDir = "/home/${user.username}/.local/share/syncthing"; # database and logs
    };
}
