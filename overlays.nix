{ nixpkgs-unstable, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      unstable = import nixpkgs-unstable { system = final.system; };
    })
    (final: prev: {
      rofi-calc-wayland = prev.rofi-calc.override { rofi-unwrapped = prev.rofi-wayland-unwrapped; };
    })
    (final: prev: {
      rofi-top-wayland = prev.rofi-top.override { rofi-unwrapped = prev.rofi-wayland-unwrapped; };
    })
  ];
}
