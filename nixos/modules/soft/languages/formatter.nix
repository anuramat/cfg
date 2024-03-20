{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alejandra # nix
    nixfmt # nix (OFFICIAL)
    shfmt # posix/bash/mksh
    stylua # Lua
    yamlfmt # YAML
    nodePackages.prettier # formatting
    black # Python
    gofumpt # strict(er) go
  ];
}
