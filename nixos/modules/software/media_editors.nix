{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ### Graphics
    # krita # raster graphics, digital art
    inkscape-with-extensions # vector graphics
    gimp-with-plugins # raster graphics
    imagemagickBig # CLI image manipulation
    libwebp # tools for WebP image format
    exiftool # read/write EXIF metadata

    ### Video
    # davinci-resolve # video editor etc
    handbrake # ghb - GUI for video converting
    ffmpeg # CLI multimedia processing

    # Audio
    sox # CLI audio processing

    # Text
    easyocr # neural OCR
    pandoc # markup converter (latex, markdown, etc)
    djvulibre # djvu tools
  ];
}
