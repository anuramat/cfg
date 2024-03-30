{
  pkgs,
  unstable,
  ...
}: {
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];
  environment.systemPackages = with pkgs; [
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
    tree
    lsof
    util-linux # was already installed but whatever
    wget
    zip
    unzip
    progress # progress status for cp etc
    nvi # vi clone
    file
    unrar-wrapper
  ];
}
