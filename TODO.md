## Restructure NixOS Configuration

### `flake.nix`
```
nixosConfiguration."<HOST>" = import ./hosts/<HOST>.nix
```

### `hosts/<HOST>.nix`
```
imports = [
    ../modules/<MODULE_1>.nix
    ../modules/<MODULE_2>.nix
    ../modules/<MODULE_3>.nix
];
```
