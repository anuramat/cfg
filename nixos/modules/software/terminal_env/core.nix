{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bash
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
    nvi # vi clone
    tree
    unrar-wrapper
    unzip
    util-linux # was already installed but whatever
    wget
    zip
  ];
}
