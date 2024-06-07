{unstable, ...}: {
  environment.systemPackages = with unstable; [
    nodePackages_latest.bash-language-server
    nodePackages_latest.yaml-language-server
    lua-language-server
    texlab
    (haskell-language-server.override {supportedGhcVersions = ["948" "927"];})
    nixd
    ccls
    nil
    pyright
    gopls
    marksman
    clang-tools
  ];
}
