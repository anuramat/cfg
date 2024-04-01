{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    persway.url = "github:nix-community/neovim-nightly-overlay";
  };
  outputs = {nixpkgs, ...} @ inputs: let
    user = import ./user.nix;
    system = "x86_64-linux";
    unstable = import inputs.nixpkgs-unstable {
      config.allowUnfree = true;
      inherit system;
    };
    overlays = with inputs; [
      neovim-nightly-overlay.overlay
    ];
  in {
    nixosConfigurations.${user.hostname} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit unstable user overlays;
      };
      modules = [./configuration.nix];
    };
  };
}
