{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    luajitPackages.luacheck
    golangci-lint # gigalinter for go
    deadnix # nix dead code linter
    statix # nix linter
    shellcheck # *sh linter
  ];
}
