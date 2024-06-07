{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    luajitPackages.luacheck # lua
    golangci-lint # go
    deadnix # nix dead code
    statix # nix
    shellcheck # *sh
    checkmake # makefile
  ];
}
