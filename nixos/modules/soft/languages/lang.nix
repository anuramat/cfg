{
  pkgs,
  unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    go
    nodejs_20
    yarn
    ruby
    perl
    llvm
    clang
    python3
    lua
    texliveFull
    cargo
    rustc
    unstable.stack
    unstable.cabal-install
  ];
}
