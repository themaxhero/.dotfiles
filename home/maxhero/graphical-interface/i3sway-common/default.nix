{ self, lib, pkgs, ... }@attrs:
let
  spawnables = import (self + /home/maxhero/graphical-interface/spawnables) attrs;
in
rec {
  volumectl = "${pkgs.avizo}/bin/volumectl";
  modifier = "Mod4";
  modifier2 = "Mod1";
  modifierCombo = "${modifier}+${modifier2}";
  floatingCriteria = [
    {
      id = "firefox";
      title = "moz-extension:.+";
    }
    {
      id = "firefox";
      title = "Password Required";
    }
    {
      title = "null";
    }
  ];

  commandMode = {
    "p" = ''exec --no-startup-id "~/.config/sway/power-menu.sh"'';
    "o" = ''exec --no-startup-id "~/.config/sway/projects.sh"'';
    "Escape" = "mode default";
  };

  window = {
    border = 1;
    titlebar = false;
    hideEdgeBorders = "both";

    commands = [
      {
        criteria = { class = "^.*"; };
        command = "border pixel 1";
      }
      {
        criteria = {
          id = "firefox";
          title = "Picture-in-Picture";
        };
        command = "floating enable sticky enable";
      }
      {
        criteria = {
          id = "firefox";
          title = "Firefox — Sharing Indicator";
        };
        command = "floating enable sticky enable";
      }
      {
        criteria = { title = "alsamixer"; };
        command = "floating enable border pixel 1";
      }
      {
        criteria = { class = "Clipgrab"; };
        command = "floating enable";
      }
      {
        criteria = { title = "File Transfer*"; };
        command = "floating enable";
      }
      {
        criteria = { class = "bauh"; };
        command = "floating enable";
      }
      {
        criteria = { class = "Galculator"; };
        command = "floating enable border pixel 1";
      }
      {
        criteria = { class = "GParted"; };
        command = "floating enable border normal";
      }
      {
        criteria = { title = "i3_help"; };
        command = "floating enable sticky enable border normal";
      }
      {
        criteria = { class = "Lightdm-settings"; };
        command = "floating enable sticky enable border normal";
      }
      {
        criteria = { class = "Lxappearance"; };
        command = "floating enable border normal";
      }
      {
        criteria = { class = "Pavucontrol"; };
        command = "floating enable";
      }
      {
        criteria = { class = "Pavucontrol"; };
        command = "floating enable";
      }
      {
        criteria = { class = "Qtconfig-qt4"; };
        command = "floating enable border normal";
      }
      {
        criteria = { class = "qt5ct"; };
        command = "floating enable sticky enable border normal";
      }
      {
        criteria = { class = "Skype"; };
        command = "floating enable border normal";
      }
      {
        criteria = { class = "(?i)virtualbox"; };
        command = "floating enable border normal";
      }
      {
        criteria = { class = "Xfburn"; };
        command = "floating enable";
      }
      {
        criteria = { class = "keepassxc"; };
        command = "floating enable";
      }
      {
        criteria = { instance = "origin.exe"; };
        command = "floating enable";
      }
      {
        criteria = { title = "Slack \\| mini panel"; };
        command = "floating enable; stick enable";
      }
    ];
  };

  i3AndSwayKeybindings = (type: lib.mkOptionDefault ({
    # Window helpers
    "${modifier}+Shift+f" = "fullscreen toggle global";
    "${modifier}+Shift+t" = "sticky toggle";

    # Volume controls
    "XF86AudioRaiseVolume" = ''
      exec "${volumectl} -u up"
    '';
    "XF86AudioLowerVolume" = ''
      exec "${volumectl} -u down"
    '';
    "XF86AudioMute" = ''
      exec "${volumectl} toggle-mute"
    '';

    # Lightweight screenshot to cliboard and temporary file
    #"Print" = "exec \"${spawnables.${type}.screenshot}\"";

    # Enter my extra modes
    "${modifier}+c" = "mode command_mode";
    "${modifier}+x" = "exec \"rofi -show calc -modi calc -no-show-match -no-sort -theme ~/.config/rofi/launchers/type-6/style-1.rasi\"";

    # Navigation Between Workspaces
    "${modifierCombo}+left" = "workspace prev";
    "${modifierCombo}+right" = "workspace next";

    # Reload/Restart
    "${modifier}+Shift+c" = "reload";
    "${modifier}+Shift+r" = "restart";
    "${modifier}+Shift+s" = "exec \"${spawnables.${type}.screenshot}\"";

    "${modifierCombo}+v" = "split v";
    "${modifierCombo}+h" = "split h";

    # My extra lot of workspaces
    "${modifier}+1" = "workspace 1";
    "${modifier}+2" = "workspace 2";
    "${modifier}+3" = "workspace 3";
    "${modifier}+4" = "workspace 4";
    "${modifier}+5" = "workspace 5";
    "${modifier}+6" = "workspace 6";
    "${modifier}+7" = "workspace 7";
    "${modifier}+8" = "workspace 8";
    "${modifier}+9" = "workspace 9";
    "${modifier}+0" = "workspace 10";
    /*
      "${modifierCombo}+1" = "workspace 11";
      "${modifierCombo}+2" = "workspace 12";
      "${modifierCombo}+3" = "workspace 13";
      "${modifierCombo}+4" = "workspace 14";
      "${modifierCombo}+5" = "workspace 15";
      "${modifierCombo}+6" = "workspace 16";
      "${modifierCombo}+7" = "workspace 17";
      "${modifierCombo}+8" = "workspace 18";
      "${modifierCombo}+9" = "workspace 19";
      "${modifierCombo}+0" = "workspace 20";
    */
    "${modifier}+Shift+1" = "move container to workspace 1";
    "${modifier}+Shift+2" = "move container to workspace 2";
    "${modifier}+Shift+3" = "move container to workspace 3";
    "${modifier}+Shift+4" = "move container to workspace 4";
    "${modifier}+Shift+5" = "move container to workspace 5";
    "${modifier}+Shift+6" = "move container to workspace 6";
    "${modifier}+Shift+7" = "move container to workspace 7";
    "${modifier}+Shift+8" = "move container to workspace 8";
    "${modifier}+Shift+9" = "move container to workspace 9";
    "${modifier}+Shift+0" = "move container to workspace 10";
    /*
      "${modifierCombo}+Shift+1" = "move container to workspace 11";
      "${modifierCombo}+Shift+2" = "move container to workspace 12";
      "${modifierCombo}+Shift+3" = "move container to workspace 13";
      "${modifierCombo}+Shift+4" = "move container to workspace 14";
      "${modifierCombo}+Shift+5" = "move container to workspace 15";
      "${modifierCombo}+Shift+6" = "move container to workspace 16";
      "${modifierCombo}+Shift+7" = "move container to workspace 17";
      "${modifierCombo}+Shift+8" = "move container to workspace 18";
      "${modifierCombo}+Shift+9" = "move container to workspace 19";
      "${modifierCombo}+Shift+0" = "move container to workspace 20";
    */
    "${modifier}+F1" = "exec \"${pkgs.ddcutil}/bin/ddcutil -d 1 setvcp 60 0x11\"";
    "${modifier}+F2" = "exec \"${pkgs.ddcutil}/bin/ddcutil -d 1 setvcp 60 0x12\"";
    "${modifier}+F3" = "exec \"${pkgs.ddcutil}/bin/ddcutil -d 1 setvcp 60 0x0f\"";
    "${modifierCombo}+F1" = "exec \"${pkgs.ddcutil}/bin/ddcutil -d 2 setvcp 60 0x11\"";
    "${modifierCombo}+F2" = "exec \"${pkgs.ddcutil}/bin/ddcutil -d 2 setvcp 60 0x12\"";
    "${modifierCombo}+F3" = "exec \"${pkgs.ddcutil}/bin/ddcutil -d 2 setvcp 60 0x0f\"";

    "${modifier}+z" = "${spawnables.${type}.lock}";
  }));
}
