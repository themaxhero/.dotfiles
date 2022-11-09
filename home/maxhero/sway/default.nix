{ config, pkgs, lib, ... }:
let
  modifier = "Mod4";
  modifier2 = "Mod1";
  gtkTheme = "Orchis-Dark";
  menu = "${pkgs.wofi}/bin/wofi -I --show drun";
  terminal = "${pkgs.alacritty}/bin/alacritty";
  lock =
    "~/.config/sway/lock.sh --indicator --indicator-radius 100 --ring-color e40000 --clock";
  modifierCombo = "${modifier}+${modifier2}";
  volumectl = "${pkgs.avizo}/bin/volumectl";
  grim = "${pkgs.grim}/bin/grim";
  slurp = "${pkgs.slurp}/bin/slurp";
  wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
  swaync-client = "${pkgs.swaynotificationcenter}/bin/swaync-client";
  swaync = "${pkgs.swaynotificationcenter}/bin/swaync";
  clipman = "${pkgs.clipman}/bin/clipman";
  nm-applet = "${pkgs.networkmanagerapplet}/bin/nm-applet";
  gtk2-rc-files = "${pkgs.orchis-theme}/share/themes/${gtkTheme}/gtk-2.0/gtkrc";
  iconTheme = "Tela-circle-dark";
  printCmd =
    "${grim} -t png -g \"$(${slurp})\" - | tee /tmp/screenshot.png | ${wl-copy} -t 'image/png'";
in {
  config = lib.mkIf config.graphical-interface.enable {
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true; # so that gtk works properly
      wrapperFeatures.base = true; # so that gtk works properly
      xwayland = true;
      config = {
        inherit modifier terminal menu;
        floating.modifier = modifier;
        bars = [ ];

        focus = { followMouse = "yes"; };

        keybindings = lib.mkOptionDefault ({
          # Window helpers
          "${modifier}+Shift+f" = "fullscreen toggle global";
          "${modifier}+Shift+t" = "sticky toggle";

          # Volume controls
          "XF86AudioRaiseVolume" = "exec ${volumectl} -u up";
          "XF86AudioLowerVolume" = "exec ${volumectl} -u down";
          "XF86AudioMute" = "exec ${volumectl} toggle-mute";

          # Lightweight screenshot to cliboard and temporary file
          "Print" = "exec ${printCmd}";

          # Notifications tray
          "${modifier}+Shift+n" = "exec ${swaync-client} -t -sw";

          # Enter my extra modes
          "${modifier}+c" = "mode command_mode";

          # Navigation Between Workspaces
          "${modifierCombo}+left" = "workspace prev";
          "${modifierCombo}+right" = "workspace next";

          # Reload/Restart
          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+r" = "restart";

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

          "${modifier}+z" = lock;
        });

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
                app_id = "firefox";
                title = "Picture-in-Picture";
              };
              command = "floating enable sticky enable";
            }
            {
              criteria = {
                app_id = "firefox";
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
              criteria = { title = "sudo"; };
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

        floating.criteria = [
          {
            app_id = "firefox";
            title = "moz-extension:.+";
          }
          {
            app_id = "firefox";
            title = "Password Required";
          }
        ];

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
          "*" = { background = "~/.wallpaper.png fill"; };
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

        modes = lib.mkOptionDefault {
          "command_mode" = {
            "p" = "exec ~/.config/sway/power-menu.sh";
            "o" = "exec ~/.config/sway/projects.sh";
            "Escape" = "mode default";
          };
        };

        startup = [
          { command = swaync; }
          { command = "${nm-applet} --indicator"; }
          { command = clipman; }
        ];
      };
      extraConfig = ''
        # Proper way to start portals
        exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP
      '';
      extraSessionCommands = ''
        # Force wayland overall.
        export BEMENU_BACKEND='wayland'
        export CLUTTER_BACKEND='wayland'
        export ECORE_EVAS_ENGINE='wayland_egl'
        export ELM_ENGINE='wayland_egl'
        export GDK_BACKEND='wayland'
        export MOZ_ENABLE_WAYLAND=1
        export QT_AUTO_SCREEN_SCALE_FACTOR=0
        export QT_QPA_PLATFORM='wayland-egl'
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export SAL_USE_VCLPLUGIN='gtk3'
        export SDL_VIDEODRIVER='wayland'
        export _JAVA_AWT_WM_NONREPARENTING=1
        export NIXOS_OZONE_WL=1

        export GTK_THEME='${gtkTheme}'
        export GTK_ICON_THEME='${iconTheme}'
        export GTK2_RC_FILES='${gtk2-rc-files}'
        export QT_STYLE_OVERRIDE='gtk2'

        # KDE/Plasma platform for Qt apps.
        export QT_QPA_PLATFORMTHEME='kde'
        export QT_PLATFORM_PLUGIN='kde'
        export QT_PLATFORMTHEME='kde'
      '';
    };
    home.packages = with pkgs; [
      swaynotificationcenter
      orchis-theme
      tela-circle-icon-theme
    ];
  };
}
