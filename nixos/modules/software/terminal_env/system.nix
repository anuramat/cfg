{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Random system stuff
    usbutils # just in case
    libusb # user-mode USB access lib
    efibootmgr # EFI boot manager editor
    xdg-user-dirs # $HOME/* dir management

    # Monitoring
    # add more tops
    glances # 24k, bloated, with a web interface
    btop # 16k
    gtop # 9.6k
    htop # 5.8k
    gotop # 2.6k
    atop # 0.757k
    nmon
    # better du
    du-dust # directory disk usage (better du)
    ncdu # directory disk usage (better du)
    # misc
    ctop # container top
    nvtop # top for GPUs
    duf # disk usage (better "df")
    acpi # battery status etc

    # Networking
    wirelesstools # iwconfig etc
    dig # dns utils
    inetutils # common network stuff
    nmap
    netcat
    socat # socket cat
  ];
}
