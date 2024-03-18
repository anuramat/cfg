let
  browser = "google-chrome.desktop";
  filemanager = "nnn.desktop";
  documents = "org.pwmt.zathura.desktop";
  editor = "nvim.desktop";
in
{
  "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
  "x-scheme-handler/vscode" = "code-url-handler.desktop";
  "x-scheme-handler/magnet" = "transmission-gtk.desktop";

  # all `text/*` types are subclasses of `text/plain`
  "text/plain" = editor;

  "inode/directory" = filemanager;
  "application/pdf" = documents;

  "x-scheme-handler/http" = browser;
  "x-scheme-handler/https" = browser;
  "x-scheme-handler/about" = browser;
  "x-scheme-handler/unknown" = browser;
  "text/html" = browser;
}
