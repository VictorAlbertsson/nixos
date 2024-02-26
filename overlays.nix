{ nixpkgs-unstable, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      unstable = import nixpkgs-unstable { system = final.system; };
    })
  ];
}
