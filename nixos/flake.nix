{
  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # modules
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # overlays
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # packages
    inputs.nix-alien.url = "github:thiagokokada/nix-alien";
  };
  outputs = {nixpkgs, ...} @ inputs: let
    user = import ./user.nix;
    unstable = import inputs.nixpkgs-unstable {
      config.allowUnfree = true;
      inherit (user) system;
    };
    overlays = with inputs; [
      neovim-nightly-overlay.overlay
    ];
  in {
    nixosConfigurations.${user.hostname} = nixpkgs.lib.nixosSystem {
      inherit (user) system;
      specialArgs = {
        inherit unstable user;
      };
      modules = [
        ./configuration.nix
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
        (_: {
          environment.systemPackages = [
            inputs.nix-alien.${user.system}.nix-alien
          ];
          nixpkgs.overlays = overlays;
        })
      ];
    };
  };
}
