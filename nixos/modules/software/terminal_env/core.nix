{pkgs, ...}: {
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];
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
