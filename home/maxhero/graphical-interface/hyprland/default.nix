{ self, pkgs, lib, config, specialArgs, hyprland-contrib, ... }@attrs:
let
  enabled = false; # specialArgs.nixosConfig.graphical-interface.enable
  env = import (self + /env) attrs;
  spawnables = import (self + /home/maxhero/graphical-interface/spawnables) attrs;
in
{
  config = lib.mkIf enabled {
    home.packages = with pkgs; [
      hyprland-contrib.packages."${pkgs.system}".grimblast
      hyprpicker
    ];
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        exec-once = [
          spawnables.wayland.bar
          spawnables.wayland.ime
          spawnables.wayland.network-applet
        ];
        input = {
          kb_layout = "us";
          kb_variant = "intl";
          follow_mouse = 1;
        };
        bind = [
          # Move Between Tiles/Windows
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          # Vim Motions
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"

          # Move Tiles
          "$mod SHIFT, left, movewindow, l"
          "$mod SHIFT, right, movewindow, r"
          "$mod SHIFT, up, movewindow, u"
          "$mod SHIFT, down, movewindow, d"

          # Vim Motions
          "$mod SHIFT, h, movewindow, l"
          "$mod SHIFT, l, movewindow, r"
          "$mod SHIFT, k, movewindow, u"
          "$mod SHIFT, j, movewindow, d"

          # kill
          "$mod SHIFT, Q, killactive"

          # Programs
          "$mod, D, exec, rofi -show drun -theme ~/.config/rofi/launchers/type-1/style-6.rasi"
          "$mod SHIFT, S, exec, grimblast copy area"
          "$mod, Return, exec, kitty"

          # Fullscreen
          "$mod, F, fakefullscreen"

          # Move to Specific Workspace
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"

          # Move Tile to Specific Workspace
          "$mod SHIFT, 1, movetoworkspacesilent, 1"
          "$mod SHIFT, 2, movetoworkspacesilent, 2"
          "$mod SHIFT, 3, movetoworkspacesilent, 3"
          "$mod SHIFT, 4, movetoworkspacesilent, 4"
          "$mod SHIFT, 5, movetoworkspacesilent, 5"
          "$mod SHIFT, 6, movetoworkspacesilent, 6"
          "$mod SHIFT, 7, movetoworkspacesilent, 7"
          "$mod SHIFT, 8, movetoworkspacesilent, 8"
          "$mod SHIFT, 9, movetoworkspacesilent, 9"
          "$mod SHIFT, 0, movetoworkspacesilent, 10"

          # Enable floating manually for windows
          "$mod, SPACE, togglefloating"
        ];
        monitor = [
          "DP-1, 3840x2160@60, 0x0, 1"
          "DP-3, 3840x2160@60, 3840x0, 1"
        ];
        general = {
          gaps_in = 8;
          gaps_out = 16;
          border_size = 1;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          layout = "dwindle";
          allow_tearing = false;
        };
        decoration = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          rounding = 10;

          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };

          drop_shadow = "yes";
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";
        };

        animations = {
          enabled = "yes";

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
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
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = "yes"; # you probably want this
        };
        master = {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true;
        };

        gestures = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = "off";
        };

        misc = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          force_default_wallpaper = -1; # Set to 0 to disable the anime mascot wallpapers
        };
        # Example per-device config
        # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
        "device:epic-mouse-v1" = {
          sensitivity = -0.5;
        };
        "$mod" = "SUPER";
      };
      extraConfig = ''
        # Get rid of that annoying message
        autogenerated = 0

        # Env
        ${builtins.foldl' (acc: v: "${acc}\nenv = ${v.name},${v.value}") "" env.hyprland_env}

        submap=resize

        binde=,H,resizeactive,-10 0
        binde=,LEFT,resizeactive,-10 0
        binde=,J,resizeactive,0 10
        binde=,DOWN,resizeactive,0 10
        binde=,K,resizeactive,0 -10
        binde=,UP,resizeactive,0 -10
        binde=,L,resizeactive,10 0
        binde=,RIGHT,resizeactive,10 0

        bind=,RETURN,submap,reset
        bind=,ESCAPE,submap,reset
        bind=$mod, R, submap, resize

        submap=reset
        bind=$mod, R, submap, resize

        # Move/resize windows with mod + LMB/RMB and dragging
        bindm = $mod, mouse:272, movewindow
        bindm = $mod, mouse:273, resizewindow
      '';
    };
  };
}
