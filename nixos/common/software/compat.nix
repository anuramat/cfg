{pkgs, ...}: {
  programs.nix-ld = {
    enable = true;
    libraries = [
    ];
  };
  environment.systemPackages = with pkgs; [
    nix-alien
  ];
}
