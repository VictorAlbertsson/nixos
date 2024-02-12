{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.kernelModules = [ "kvm-amd" ];

  boot.initrd.systemd.enable = true;
  boot.initrd.availableKernelModules = [ "amdgpu" "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" "amdgpu" ];
  boot.initrd.luks.devices."encrypted" = {
    device = "/dev/disk/by-uuid/e6b71e20-191b-434d-b0ad-b6e489f31712";
    preLVM = true;
  };

  hardware.tuxedo-keyboard.enable = true;
  boot.kernelParams = [
    "tuxedo_keyboard.mode=0"
    "tuxedo_keyboard.brightness=255"
    "tuxedo_keyboard.color_left=0xff0a0a"
  ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a6c78a81-e429-4057-b243-00341ae8e711";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/3D9A-A540";
      fsType = "vfat";
    };

  swapDevices = [ ];
  zramSwap.enable = true;
  zramSwap.memoryPercent = 25;

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
