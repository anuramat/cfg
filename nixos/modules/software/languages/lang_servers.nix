{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    nodePackages_latest.bash-language-server
    nodePackages_latest.yaml-language-server
    lua-language-server
    unstable.texlab
    unstable.haskell-language-server
    unstable.nixd
    unstable.nil
    unstable.pyright
    unstable.gopls
    unstable.marksman
    unstable.clang-tools
  ];
}
