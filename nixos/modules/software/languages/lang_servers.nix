{unstable, ...}: {
  environment.systemPackages = with unstable; [
    nodePackages_latest.bash-language-server
    nodePackages_latest.yaml-language-server
    lua-language-server
    texlab
    haskell-language-server
    nixd
    ccls
    nil
    pyright
    gopls
    marksman
    clang-tools
  ];
}
