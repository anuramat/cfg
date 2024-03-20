{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Terminals
    foot # minimal terminal
    unstable.alacritty # gpu terminal
    unstable.alacritty-theme
    cool-retro-term # cute terminal

    # Basics
    gnumake
    gcc
    bash
    killall
    coreutils-full
    coreutils-prefixed # good for mac compatibility
    curl
    git
    less
    lsof
    wget
    zip
    unzip
    progress # progress status for cp etc
    nvi # vi clone
    file

    # Web
    grpcui # postman for grpc
    grpcurl # curl for grpc
    httpie # better curl
    prettyping # better "ping"
    kubectx
    kubectl

    # Completion # TODO check if this is even used
    bash-completion
    nix-bash-completions

    # File managers
    xdragon
    # TODO choose one
    vifm
    mc
    ranger
    lf
    nnn
    broot
    xplr

    # Monitoring
    htop # better top
    atop # even better top
    ctop # container top
    nvtop # top for GPUs
    duf # disk usage (better "df")
    du-dust # directory disk usage (better du)
    ncdu # directory sidk usage (better du)
    acpi # battery status etc

    # Git
    ghq # git repository manager
    git-filter-repo # rewrite/analyze repository history
    gh # GitHub CLI

    # Networking
    wirelesstools # iwconfig etc
    dig # dns utils
    inetutils # common network stuff
    nmap
    netcat

    # Random linux shit
    usbutils # just in case
    libusb # user-mode USB access lib
    efibootmgr # EFI boot manager editor
  ];
}
