let
  setMany = app: types: (builtins.listToAttrs (map (x: {
      name = x;
      value = app;
    })
    types));

  browser = "google-chrome.desktop";
  fileManager = "nnn.desktop";
  documentViewer = "org.pwmt.zathura.desktop";
  # textEditor = "nvim.desktop";
  textEditor = "neovide.desktop";
  imageViewer = "org.nomacs.ImageLounge.desktop";
  torrentClient = "transmission-gtk.desktop";
  videoPlayer = "mpv.desktop";
in {
  xdg.mime = {
    enable = true;
    defaultApplications =
      {
        "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
        "x-scheme-handler/vscode" = "code-url-handler.desktop";
        "x-scheme-handler/magnet" = torrentClient;
        "inode/directory" = fileManager;
      }
      // setMany textEditor (import ./text.nix)
      // setMany browser (import ./browser.nix)
      // setMany imageViewer (import ./images.nix)
      // setMany videoPlayer (import ./multimedia.nix)
      // setMany documentViewer (import ./documents.nix);
  };
}
