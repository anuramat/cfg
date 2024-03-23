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
    nvi
    neovim
    unstable.vis
    unstable.helix
    unstable.vim-full
  ];
}
