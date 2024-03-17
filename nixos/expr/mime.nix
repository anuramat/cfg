{
  "x-scheme-handler/http" = [ "google-chrome.desktop" ];
  "x-scheme-handler/https" = [ "google-chrome.desktop" ];
  "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
  "x-scheme-handler/vscode" = [ "code-url-handler.desktop" ];

  # all `text/*` types are subclasses of `text/plain`
  "text/plain" = [ "nvim.desktop" ];
  "application/x-shellscript" = [ "nvim.desktop" ];
  # "text/x-c" = [ "nvim.desktop" ];
  # "text/x-c++" = [ "nvim.desktop" ];

  "inode/directory" = [ "nnn.desktop" ];

  # "application/pdf" = [

  "image/gif" = [ "org.nomacs.ImageLounge.desktop" ];
  "image/jpeg" = [ "org.nomacs.ImageLounge.desktop" ];
  "image/png" = [ "org.nomacs.ImageLounge.desktop" ];
  "image/bmp" = [ "org.nomacs.ImageLounge.desktop" ];
  "image/tiff" = [ "org.nomacs.ImageLounge.desktop" ];
  "image/x-eps" = [ "org.nomacs.ImageLounge.desktop" ];
  "image/x-ico" = [ "org.nomacs.ImageLounge.desktop" ];
  "image/x-portable-bitmap" = [ "org.nomacs.ImageLounge.desktop" ];
  "image/x-portable-graymap" = [ "org.nomacs.ImageLounge.desktop" ];
  "image/x-portable-pixmap" = [ "org.nomacs.ImageLounge.desktop" ];
  "image/x-xbitmap" = [ "org.nomacs.ImageLounge.desktop" ];
  "image/x-xpixmap" = [ "org.nomacs.ImageLounge.desktop" ];
}
