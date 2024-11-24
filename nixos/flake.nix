{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-alien.url = "github:thiagokokada/nix-alien";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };
  outputs = {nixpkgs, ...} @ inputs: let
    user = {
      username = "anuramat";
      fullname = "Arsen Nuramatov";
      timezone = "Europe/Berlin";
      defaultLocale = "en_US.UTF-8";
    };
    unstable = import inputs.nixpkgs-unstable {
      config.allowUnfree = true;
      system = "x86_64-linux";
    };
    overlays = with inputs; [
      nix-alien.overlays.default
    ];
  in {
    nixosConfigurations = {
      anuramat-ll7 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit user unstable inputs;};
        modules = [
          ./configuration.nix
          ./machines/anuramat-ll7.nix
          inputs.nixos-hardware.nixosModules.common-cpu-intel
          inputs.nixos-hardware.nixosModules.common-gpu-intel
          (_: {
            system.stateVersion = "24.05";
            networking.hostName = "anuramat-ll7";
            nixpkgs.overlays = overlays;
          })
        ];
      };
      anuramat-t480 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit user unstable inputs;};
        modules = [
          ./configuration.nix
          ./machines/anuramat-t480.nix
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
          (_: {
            system.stateVersion = "24.05";
            networking.hostName = "anuramat-t480";
            nixpkgs.overlays = overlays;
          })
        ];
      };
    };
  };
}
