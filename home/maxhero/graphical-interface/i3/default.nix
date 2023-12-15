{ self, pkgs, ... }:
let
  i3SwayCommon = import (self + /home/maxhero/graphical-interface/i3sway-common);
  spawnables = import (self + /home/maxhero/graphical-interface/spawnables);
in
{
  config = lib.mkIf nixosConfig.graphical-interface.enable {
    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        terminal = spawnables.xorg.terminal;
        modifier = i3AndSwayKeybindings.modifier;
        assigns = { };
        bars = [ ];
        colors = { };
        focus.followMouse = true;
        fonts = {
          names = [ "scientifica" ];
          size = 8.0;
        };
        keybindings = (i3SwayCommon.i3AndSwayKeybindings "xorg");
        floating.criteria = i3SwayCommon.floatingCriteria;
        window = i3SwayCommon.window;
        modes = lib.mkOptionDefault {
          "command_mode" = i3SwayCommon.commandMode;
        };
        # Could be the same as sway if I find tools/daemons that are compatible with both Xorg and Wayland
        startup = [
          { command = "--no-startup-id ${spawnables.xorg.notification-daemon}"; }
          { command = "--no-startup-id ${spawnables.xorg.bar}"; always = true; }
          { command = "--no-startup-id ${spawnables.xorg.ime}"; }
          { command = "--no-startup-id ${spawnables.xorg.wallpaper}"; }
          { command = "--no-startup-id ${nm-applet} --indicator"; }
          { command = "--no-startup-id ${clipman}"; }
        ];
      };
    };
  };
}
