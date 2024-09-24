{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # ~~~~~~~~~~~~~~~~~~~~~~ core {{{1 ~~~~~~~~~~~~~~~~~~~~~~~ #
    bash
    bash-completion
    bc # simple calculator
    coreutils-full
    coreutils-prefixed # good for mac compatibility
    curl
    file
    gcc
    git
    gnumake
    killall
    less
    lsof
    moreutils # random unixy goodies
    nix-bash-completions
    nvi # vi clone
    tmux # just in case
    tree
    unrar-wrapper
    unzip
    util-linux # was already installed but whatever
    wget
    zip
    # ~~~~~~~~~~~~~~~~~~ system utils {{{1 ~~~~~~~~~~~~~~~~~~~ #
    acpi # battery status etc
    dmidecode # read hw info from bios using smbios/dmi
    efibootmgr # EFI boot manager editor
    hwinfo
    libusb # user-mode USB access lib
    libva-utils # vainfo - info on va-api
    lshw # hw info
    pciutils
    smem # ram usage
    usbutils
    v4l-utils
    xdg-user-dirs # $HOME/* dir management
    # ~~~~~~~~~~~~~~~~~~~ networking {{{1 ~~~~~~~~~~~~~~~~~~~~ #
    dig # dns utils
    gsocket # get shit through nat
    inetutils # common network stuff
    netcat
    nmap
    socat # socket cat
    wirelesstools # iwconfig etc
    # }}}
  ];
}
# vim: fdm=marker fdl=0
