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
    # haskell
    unstable.stack
    unstable.cabal-install
  ];
}
