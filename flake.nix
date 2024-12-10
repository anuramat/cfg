{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };
  outputs = {nixpkgs, ...} @ inputs: let
    user = import ./nix/user.nix;
    unstable = import inputs.nixpkgs-unstable {
      config.allowUnfree = true;
      system = "x86_64-linux";
    };
    specialArgs = {inherit user unstable inputs;};
    system = name: {
      inherit name;
      value = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./configuration.nix
          ./nix/machines/${name}.nix
        ];
      };
    };
  in {
    nixosConfigurations = builtins.listToAttrs (map system user.machines);
  };
}
