let
  browser = "google-chrome.desktop";
  fileManager = "nnn.desktop";
  documentViewer = "org.pwmt.zathura.desktop";
  editor = "nvim.desktop";
  imageViewer = "org.nomacs.ImageLounge.desktop";
  torrentClient = "transmission-gtk.desktop";
  videoPlayer = "mpv.desktop";
  # all `text/*` types are subclasses of `text/plain`, yet it doesn't work...
  setMany = app: types: (builtins.listToAttrs (map (x: { name = x; value = app; }) types));
in
{
  "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
  "x-scheme-handler/vscode" = "code-url-handler.desktop";
  "x-scheme-handler/magnet" = torrentClient;
  "inode/directory" = fileManager;
  "application/pdf" = documentViewer;
} // setMany editor [
  "application/x-shellscript"
  "text/english"
  "text/plain"
  "text/x-c"
  "text/x-c++"
  "text/x-c++hdr"
  "text/x-c++src"
  "text/x-chdr"
  "text/x-csrc"
  "text/x-java"
  "text/x-makefile"
  "text/x-moc"
  "text/x-pascal"
  "text/x-tcl"
  "text/x-tex"
] // setMany browser [
  # "x-scheme-handler/about"
  # "x-scheme-handler/unknown"
  "application/pdf"
  "application/rdf+xml"
  "application/rss+xml"
  "application/xhtml+xml"
  "application/xhtml_xml"
  "application/xml"
  "image/gif"
  "image/jpeg"
  "image/png"
  "image/webp"
  "text/html"
  "text/xml"
  "x-scheme-handler/http"
  "x-scheme-handler/https"
] // setMany imageViewer [
  "image/avif"
  "image/bmp"
  "image/gif"
  "image/heic"
  "image/heif"
  "image/jpeg"
  "image/jxl"
  "image/png"
  "image/tiff"
  "image/webp"
  "image/x-eps"
  "image/x-ico"
  "image/x-portable-bitmap"
  "image/x-portable-graymap"
  "image/x-portable-pixmap"
  "image/x-xbitmap"
  "image/x-xpixmap"
] // setMany videoPlayer (import ./mime/av.nix)
