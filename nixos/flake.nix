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
      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFPgKxqnXU0UAshEUDLcVZW6LkfMM0JE2yuhkyjXSxUI anuramat-t480"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKl0YHcx+ju+3rsPerkAXoo2zI4FXRHaxzfq8mNHCiSD anuramat-iphone16"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIORDkTNsAaKxMF/VIfoI+FXvcLARbswddfqtHNkuTsxR anuramat-ll7"
      ];
    };
    unstable = import inputs.nixpkgs-unstable {
      config.allowUnfree = true;
      system = "x86_64-linux";
    };
    # TODO write a wrapper function
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
          })
        ];
      };
      anuramat-t480 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit user unstable inputs;};
        modules = [
          ./configuration.nix
          ./machines/anuramat-t480.nix
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
        ];
      };
    };
  };
}
