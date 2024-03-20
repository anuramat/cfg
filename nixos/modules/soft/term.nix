{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    foot # minimal terminal
    unstable.alacritty # gpu terminal
    unstable.alacritty-theme
    cool-retro-term # cute terminal

    ### Basics
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

    # completion
    bash-completion
    nix-bash-completions

    ### File managers
    xdragon
    # TODO choose one
    vifm
    mc
    ranger
    lf
    nnn
    broot
    xplr

    # random
    usbutils # just in case
  ];
}
