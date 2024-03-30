{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Random system stuff
    usbutils # just in case
    libusb # user-mode USB access lib
    efibootmgr # EFI boot manager editor
    xdg-user-dirs # $HOME/* dir management

    # Monitoring
    # add more tops
    btop
    vtop
    htop # better top
    atop # even better top
    ctop # container top
    nvtop # top for GPUs
    duf # disk usage (better "df")
    du-dust # directory disk usage (better du)
    ncdu # directory sidk usage (better du)
    acpi # battery status etc

    # Networking
    wirelesstools # iwconfig etc
    dig # dns utils
    inetutils # common network stuff
    nmap
    netcat
  ];
}
