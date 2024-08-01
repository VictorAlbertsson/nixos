{ config, lib, pkgs, ... }:
let
boot-theme = "rings";
boot-theme-packages = pkgs.adi1090x-plymouth-themes.override {
  selected_themes = [ boot-theme ];
};
in {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.initrd.systemd.enable = true;
  boot.initrd.luks.devices."encrypted" = {
    device = "/dev/disk/by-uuid/e6b71e20-191b-434d-b0ad-b6e489f31712";
    preLVM = true;
  };

  hardware.tuxedo-keyboard.enable = true;
  boot.kernelParams = [
    "tuxedo_keyboard.mode=0"
    "tuxedo_keyboard.brightness=255"
    "tuxedo_keyboard.color_left=0xff0a0a"
    "quiet"
    "splash"
  ];

  zramSwap.enable = true;
  zramSwap.memoryPercent = 25;

  hardware.cpu.amd.updateMicrocode = true;
  powerManagement.enable = true;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      warn-dirty = false;
      trusted-users = [ "@wheel" ];
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "1";
    configurationLimit = 10;
  };

# Patch for a NetworkManager bug,
# which causes `nixos-rebuild switch` to fail
  systemd.services."NetworkManager-wait-online".enable = false;

  boot.plymouth = {
    enable = true; # DEBUGGING
    theme = boot-theme;
    themePackages = [ boot-theme-packages ];
  };

  # `fwupd-efi` broken currently, also TUXEDO doesn't yet post firmware to LVFS
  ## services.fwupd = {
  ##   enable = true;
  ##   package = pkgs.fwupd-efi;
  ## };

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/keys/age/sops";
    secrets = {
      "pvpn-key" = {};
    };
  };

#services.openssh.enable = true;
  networking = {
    hostName = "typewriter";
    networkmanager.enable = true;
    firewall.checkReversePath = false;
    wg-quick.interfaces."wg0" = {
      address = [ "10.2.0.2/32" ];
      dns = [ "10.2.0.1" ];
      privateKeyFile = config.sops.secrets.pvpn-key.path;
      peers = [
      { # CH.65
        publicKey = "17I34jHOMcmI7LKBqxosTfLgwGjO5OKApLcRSPlyymM=";
        allowedIPs = [ "0.0.0.0/0" ];
        endpoint = "185.159.157.13:51820";
      }
      ];
    };
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [
      amdvlk
      mesa
    ];
  };

# TODO: Specify which fonts to use where
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "M+1Code Nerd Font Mono" ];
        sansSerif = [ "M+1 Nerd Font" ];
        serif = [ "M+1 Nerd Font" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "MPlus" ]; })
      noto-fonts-color-emoji
    ];
  };

  ##console = {
  ##  enable = true;
  ##  earlySetup = true;
  ##  font = "ter-i32b";
  ##  packages = with pkgs; [ terminus_font ];
  ##};

  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
    ];
# TODO: Replace this line with a proper config
    config.common.default = "*";
  };

  services.printing.enable = true;
  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";

  programs.bash = {
    enableCompletion = true;
    shellAliases = {
      "grep" = "grep --color=auto";
      "-c" = "clear";
      "-l" = "eza -lhas type --color=auto";
      "-t" = "eza -TDhas type --color=auto";
    };
    promptInit = ''
      PS1=" ⟪\[\e[1;34m\]\u\[\e[0m\]@\[\e[1;34m\]\h\[\e[0m\]⟫\n ↦ "
      '';
  };

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "Hyprland";
        user = "overlord";
      };
      default_session = {
        command = "Hyprland";
        user = "overlord";
      };
    };
  };

  users.users."overlord" = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  environment.systemPackages = with pkgs; [
    git
    age
    bat
    eza
    sops
    wget
    playerctl
    brightnessctl
  ];

  system.stateVersion = "23.11";
}
