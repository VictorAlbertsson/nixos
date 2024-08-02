{ lib, config, pkgs, nix-colors, ... }:
{
  imports = [
    nix-colors.homeManagerModule
    ./hyprland
    ./neovim
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
    plugins = [ pkgs.rofi-top pkgs.rofi-calc ];
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "M+1Code Nerd Font";
      size = 16;
    };
    shellIntegration.enableBashIntegration = true;
  };

  #programs.foot = {
  #  enable = true;
  #  server.enable = true;
  #  settings = {
  #    main = {
  #      font = "M+1Code Nerd Font:size=12";
	#      dpi-aware = "yes";
  #    };
  #    key-bindings = {
  #      clipboard-copy = "Control+Shift+c XF86Copy";
  #      clipboard-paste = "Control+Shift+v XF86Paste";
  #      unicode-input = "Control+Shift+u";
  #    };
  #    colors = {
  #      background = "${config.colorscheme.palette.base00}"; # "2e3440"
  #      foreground = "${config.colorscheme.palette.base05}"; # "e5e9f0"

  #      #* normal
  #      regular0 = "${config.colorscheme.palette.base00}"; # "2e3440"
  #      regular1 = "${config.colorscheme.palette.base0B}"; # "bf616a"
  #      regular2 = "${config.colorscheme.palette.base0E}"; # "a3be8c"
  #      regular3 = "${config.colorscheme.palette.base0D}"; # "ebcb8b"
  #      regular4 = "${config.colorscheme.palette.base09}"; # "81a1c1"
  #      regular5 = "${config.colorscheme.palette.base0F}"; # "b48ead"
  #      regular6 = "${config.colorscheme.palette.base08}"; # "88c0d0"
  #      regular7 = "${config.colorscheme.palette.base05}"; # "e5e9f0"

  #      #* bright
  #      bright0 = "${config.colorscheme.palette.base04}"; # "4c566a"
  #      bright1 = "${config.colorscheme.palette.base0C}"; # "d08770"
  #      bright2 = "${config.colorscheme.palette.base01}"; # "3b4252"
  #      bright3 = "${config.colorscheme.palette.base02}"; # "434c5e"
  #      bright4 = "${config.colorscheme.palette.base04}"; # "d8dee9"
  #      bright5 = "${config.colorscheme.palette.base06}"; # "eceff4"
  #      bright6 = "${config.colorscheme.palette.base0A}"; # "5e81ac"
  #      bright7 = "${config.colorscheme.palette.base07}"; # "8fbcbb"

  #      #* misc
  #      selection-background = "${config.colorscheme.palette.base05}"; # "e5e9f0"
  #      selection-foreground = "${config.colorscheme.palette.base00}"; # "2e3440"
  #      urls = "${config.colorscheme.palette.base04}"; # "d8dee9"
  #      jump-labels = "${config.colorscheme.palette.base00} ${config.colorscheme.palette.base0D}"; # "2e3440 ebcb8b"
  #      scrollback-indicator = "${config.colorscheme.palette.base00} ${config.colorscheme.palette.base04}"; # "2e3440 d8dee9"
  #    };
  #  };
  #};

  home.packages = with pkgs; [
    # Utilities
    # =========
    xwayland
    xterm
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
    cliphist
    wl-clipboard
    rofi-bluetooth
    # Desktop
    # =======
    brave
    unstable.protonmail-desktop
    obsidian
    prismlauncher
  ];
}
