{
  description = "NixOS Configuration for `typewriter`";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, nix-colors, sops-nix, home-manager, hyprland, ...}:
  {
    nixosConfigurations = {
      "typewriter" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit nixpkgs-unstable nix-colors hyprland;
        };
        modules = [
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          hyprland.nixosModules.default
          ./overlays.nix
          ./hosts/typewriter
          {
            home-manager.extraSpecialArgs = { inherit nix-colors hyprland; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."overlord" = import ./users/overlord;
          }
        ];
      };
    };
  };
}
