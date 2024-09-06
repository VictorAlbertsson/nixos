{ lib, config, pkgs, nix-colors, ... }:
{
  imports = [
    nix-colors.homeManagerModule
    ./hyprland
    ./neovim
    ./emacs
  ];

  programs.home-manager.enable = true;
  home = {
    username = "overlord";
    homeDirectory = "/home/overlord";
    stateVersion = "23.11";
    # For linewise bash completion
    file.".inputrc".text = ''
      set completion-display-width 0
    '';
  };

  xdg.desktopEntries = {
    obsidian = {
      name = "Obsidian";
      exec = "obsidian --ozone-platform=wayland %U";
    };
  };

  #* `config`
  colorscheme = {
    slug = "nord";
    name = "Nord";
    author = "arcticicestudio";
    variant = "dark";
    palette = {
      base00 = "2E3440";
      base01 = "3B4252";
      base02 = "434C5E";
      base03 = "4C566A";
      base04 = "D8DEE9";
      base05 = "E5E9F0";
      base06 = "ECEFF4";
      base07 = "8FBCBB";
      base08 = "88C0D0";
      base09 = "81A1C1";
      base0A = "5E81AC";
      base0B = "BF616A";
      base0C = "D08770";
      base0D = "EBCB8B";
      base0E = "A3BE8C";
      base0F = "B48EAD";
    };
  };

  #services.gnome-keyring.enable = true;
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  services.ssh-agent.enable = true;
  programs.git = {
    enable = true;
    userName = "Victor Albertsson";
    userEmail = "github.301cs@silomails.com";
    extraConfig.init.defaultBranch = "master";
  };

  programs.bash.enable = true;
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;
  };

  services.mpris-proxy.enable = true;
  services.playerctld = {
    enable = true;
    package = pkgs.playerctl;
  };

  programs.rofi = {
    enable = true;
    cycle = true;
    theme = "paper-float";
    package = pkgs.rofi-wayland;
    plugins = [ pkgs.rofi-top-wayland pkgs.rofi-calc-wayland ];
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "M+1Code Nerd Font";
      size = 16;
    };
    shellIntegration.enableBashIntegration = true;
  };

  home.packages = with pkgs; [
    # Utilities
    # =========
    xwayland
    xterm
    socat
    zoxide
    jq
    htop
    timer
    teapot
    fastfetch
    cmatrix
    # TODO: Replace `pwvucontrol` with an EWW widget
    pwvucontrol
    # Hyprland
    # ========
    swww 
    rbw
    cliphist
    pinentry-all
    wl-clipboard
    rofi-bluetooth
    rofi-rbw-wayland
    #rbw
    # Desktop
    # =======
    brave
    vivaldi
    vivaldi-ffmpeg-codecs
    unstable.protonmail-desktop
    obsidian
    prismlauncher
  ];
}
