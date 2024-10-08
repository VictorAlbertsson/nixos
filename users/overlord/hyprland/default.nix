{ pkgs, ... }:
{
  home.packages = with pkgs; [ wtype ];
  programs.eww = {
    enable = true;
    configDir = ./eww;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
	      # Start `eww`
	      "eww daemon"
	      "eww open systembar"
	      # Set wallpaper
	      "swww init"
	      "swww img ~/wallpaper.jpg"
              # Start `cliphist` daemon
	      "wl-paste --watch cliphist store"
              # Clear clipboard on startup
	      "cliphist wipe"
      ];
      monitor = ",highres,auto,2";
      xwayland.force_zero_scaling = true;
      env = [
        "XCURSOR_SIZE,32"
      ];
      input = {
        kb_layout = "us";
	      kb_variant = "intl";
	      kb_options = "caps:escape";
	      follow_mouse = "1";
	      touchpad.natural_scroll = "yes";
	      sensitivity = "0";
      };
      "$mainMod" = "SUPER";
      bindm = [
        "$mainMod, mouse:272, movewindow"
	      "$mainMod, mouse:273, resizewindow"
      ];
      bindl = [
        ", XF86AudioPlay, exec, playerctl play-pause"
	      ", XF86AudioPause, exec, playerctl pause"
	      ", XF86AudioNext, exec, playerctl next"
	      ", XF86AudioPrev, exec, playerctl prev"
      ];
      bind = [
	      "$mainMod, L, exec, rofi -show drun -display-drun 'Launch'"
	      "$mainMod, K, killactive"
        "$mainMod, J, exec, kitty"
        "$mainMod, O, exec, rofi -show top -modi top -display-top 'Top'"
        ''$mainMod, M, exec, rofi -show calc -modi calc -display-calc 'Calc' -no-show-match -no-sort -no-persist-history -calc-command "wtype '{result}'"''
	      "$mainMod, H, exec, cliphist list | rofi -dmenu -p 'History' | cliphist decode | wl-copy"
	      "$mainMod, U, exec, rofi-bluetooth"
	      "$mainMod, I, exec, rofi-rbw --typer wtype --clipboarder wl-copy --clear-after 30"
	      "$mainMod, F, togglefloating,"
	      "$mainMod, left, movefocus, l"
	      "$mainMod, right, movefocus, r"
	      "$mainMod, up, movefocus, u"
	      "$mainMod, down, movefocus, d"
	      "$mainMod, 1, workspace, 1"
	      "$mainMod, 2, workspace, 2"
	      "$mainMod, 3, workspace, 3"
	      "$mainMod, 4, workspace, 4"
	      "$mainMod, 5, workspace, 5"
	      "$mainMod, 6, workspace, 6"
	      "$mainMod, 7, workspace, 7"
	      "$mainMod, 8, workspace, 8"
	      "$mainMod, 9, workspace, 9"
	      "$mainMod, 0, workspace, 10"
	      "$mainMod SHIFT, 1, movetoworkspace, 1"
	      "$mainMod SHIFT, 2, movetoworkspace, 2"
	      "$mainMod SHIFT, 3, movetoworkspace, 3"
	      "$mainMod SHIFT, 4, movetoworkspace, 4"
	      "$mainMod SHIFT, 5, movetoworkspace, 5"
	      "$mainMod SHIFT, 6, movetoworkspace, 6"
	      "$mainMod SHIFT, 7, movetoworkspace, 7"
	      "$mainMod SHIFT, 8, movetoworkspace, 8"
	      "$mainMod SHIFT, 9, movetoworkspace, 9"
	      "$mainMod SHIFT, 0, movetoworkspace, 10"
      ];
      general = {
        gaps_in = "5";
	      gaps_out = "10";
	      border_size = "2";
	      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
	      "col.inactive_border" = "rgba(595959aa)";
	      layout = "dwindle";
	      allow_tearing = "false";
      };
      decoration = {
        rounding = "10";
	      drop_shadow = "yes";
	      shadow_range = "4";
	      shadow_render_power = "3";
	      "col.shadow" = "rgba(1a1a1aee)";
	      blur = {
	        enabled = "true";
	        size = "3";
	        passes = "1";
	      };
      };
      animations = {
        enabled = "yes";
	      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
	      animation = [
	        "windows, 1, 7, myBezier"
	        "windowsOut, 1, 7, default, popin 80%"
	        "border, 1, 10, default"
	        "borderangle, 1, 8, default"
	        "fade, 1, 7, default"
	        "workspaces, 1, 6, default"
	      ];
      };
      dwindle = {
        pseudotile = "yes";
	      preserve_split = "yes";
      };
      #master = {
      #  new_is_master = "true";
      #};
      gestures = {
        workspace_swipe = "off";
      };
      misc = {
        force_default_wallpaper = "0";
      };
    };
  };
}
