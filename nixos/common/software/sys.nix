{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # ~~~~~~~~~~~~~~~~~~ system utils {{{1 ~~~~~~~~~~~~~~~~~~~ #
    libva-utils # vainfo - info on va-api
    usbutils
    pciutils
    hwinfo
    v4l-utils
    libusb # user-mode USB access lib
    efibootmgr # EFI boot manager editor
    xdg-user-dirs # $HOME/* dir management
    dmidecode # read hw info from bios using smbios/dmi
    lshw # hw info
    # ~~~~~~~~~~~~~~~~~~~ monitoring {{{1 ~~~~~~~~~~~~~~~~~~~~ #
    btop
    gtop
    gotop
    htop
    # better du
    du-dust # pretty `du`
    ncdu # interactive `du`
    # misc
    iotop
    smem # ram usage
    ctop # container top
    podman-tui # podman container status
    unstable.nvtopPackages.full # top for GPUs
    nvitop # nvidia top
    duf # disk usage (better "df")
    acpi # battery status etc
    # ~~~~~~~~~~~~~~~~~~~ networking {{{1 ~~~~~~~~~~~~~~~~~~~~ #
    wirelesstools # iwconfig etc
    dig # dns utils
    inetutils # common network stuff
    nmap
    netcat
    socat # socket cat
    gsocket # get shit through nat
    # }}}
  ];
}
# vim: fdm=marker fdl=0
