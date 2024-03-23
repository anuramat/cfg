{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    nvi
    unstable.neovim
    unstable.vis
    unstable.helix
    unstable.vim-full
  ];
}
