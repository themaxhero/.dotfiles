{ self, pkgs, lib, specialArgs, ... }@attrs:
let
  i3SwayCommon = import (self + /home/maxhero/graphical-interface/i3sway-common) attrs;
  spawnables = import (self + /home/maxhero/graphical-interface/spawnables) attrs;
  env = import (self + /env) attrs;
in
{
  config = lib.mkIf false { #specialArgs.nixosConfig.graphical-interface.enable {
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true; # so that gtk works properly
      wrapperFeatures.base = true; # so that gtk works properly
      xwayland = true;
      config = {
        menu = spawnables.wayland.menu;
        terminal = spawnables.wayland.terminal;
        modifier = i3SwayCommon.modifier;
        floating.modifier = i3SwayCommon.modifier;
        bars = [ ];
        focus.followMouse = "yes";
        keybindings = (i3SwayCommon.i3AndSwayKeybindings "wayland");
        window = i3SwayCommon.window;
        floating.criteria = i3SwayCommon.swayFloatingCriteria;
        fonts = {
          names = [ "scientifica" ];
          size = 8.0;
        };

        input = {
          "*" = {
            xkb_layout = "us";
            xkb_variant = "intl";
            repeat_delay = "1000";
            repeat_rate = "35";
          };
        };

        output = {
          "*" = { background = "~/.wallpaper.jpg fill"; };
          DP-1 = {
            pos = "0 0";
            mode = "3840x2160@60.000000hz";
          };
          DP-2 = {
            pos = "3840 0";
            mode = "3840x2160@60.000000hz";
          };
        };

        left = "h";
        right = "l";
        up = "k";
        down = "j";
        modes = lib.mkOptionDefault { "command_mode" = i3SwayCommon.commandMode; };
        startup = [
          { command = "${pkgs.swaynotificationcenter}/bin/swaync"; }
          { command = "${spawnables.wayland.network-applet}"; }
          { command = "${pkgs.clipman}/bin/clipman"; }
        ];
      };
      extraConfig = ''
        # Proper way to start portals
        exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP
      '';
      extraSessionCommands = ''
        # Env
        ${builtins.concatStringsSep "\n" (builtins.map (v: "export ${v.name}='${v.value}'") env.sway_env)}
      '';
    };
  };
}
