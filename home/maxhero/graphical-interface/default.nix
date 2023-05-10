{ self, config, pkgs, nur, lib, specialArgs, ... }:
with specialArgs;
let
  nixosConfig = specialArgs.nixosConfig;
  firefox = "${pkgs.firefox}/bin/firefox";
  modifier = "Mod4";
  modifier2 = "Mod1";
  gtkTheme = "Orchis-Dark";
  menu = "${pkgs.wofi}/bin/wofi -I --show drun";
  terminal = "${pkgs.alacritty}/bin/alacritty";
  lxqt-sudo = "${pkgs.lxqt.lxqt-sudo}/bin/lxqt-sudo";
  defaultBrowser = "firefox.desktop";
  discord = "${pkgs.discord}/bin/discord";
  iconTheme = "Tela-circle-dark";
  lock = "~/.config/sway/lock.sh --indicator --indicator-radius 100 --ring-color e40000 --clock";
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
  printCmd = "${grim} -t png -g \"$(${slurp})\" - | tee /tmp/screenshot.png | ${wl-copy} -t 'image/png'";
  isUchigatana = nixosConfig.networking.hostName == "uchigatana";
  batteryComponent = ''
    "custom/left-arrow-dark",
    "battery",
    "custom/left-arrow-light",
  '';
  battery = if isUchigatana then batteryComponent else "";
  fontSize = if isUchigatana then 16 else 24;
  waybar = "${pkgs.waybar}/bin/waybar";
  i3AndSwayKeybindings = lib.mkOptionDefault ({
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
    "${modifier}+Shift+s" = "exec \"${pkgs.flameshot}/bin/flameshot gui\"";

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
    "${modifier}+F1" = "exec \"${pkgs.ddcutil}/bin/ddcutil -d 1 setvcp 60 0x11\"";
    "${modifier}+F2" = "exec \"${pkgs.ddcutil}/bin/ddcutil -d 1 setvcp 60 0x12\"";
    "${modifier}+F3" = "exec \"${pkgs.ddcutil}/bin/ddcutil -d 1 setvcp 60 0x0f\"";

    "${modifier}+z" = lock;
  });
  i3FloatingCriteria = [
    {
      id = "firefox";
      title = "moz-extension:.+";
    }
    {
      id = "firefox";
      title = "Password Required";
    }

  ];
  swayFloatingCriteria = [
    {
      app_id = "firefox";
      title = "moz-extension:.+";
    }
    {
      app_id = "firefox";
      title = "Password Required";
    }
  ];
  i3Window = {
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
  swayWindow = {
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
  commandMode = {
    "p" = ''exec --no-startup-id "~/.config/sway/power-menu.sh"'';
    "o" = ''exec --no-startup-id "~/.config/sway/projects.sh"'';
    "Escape" = "mode default";
  };
in {
  config = lib.mkIf nixosConfig.graphical-interface.enable {
    dconf.settings = {
      "com/github/jkotra/eovpn" = {
        dark-theme = true;
        req-auth = false;
        show-flag = false;
      };

      "desktop/ibus/general" = {
        engines-order = [ "xkb:us:intl" "anthy" ];
        use-system-keyboard-layout = true;
      };

      "org/gnome/TextEditor" = {
        custom-font = "Red Hat Mono Light 16";
        highlight-current-line = false;
        indent-style = "space";
        show-grid = false;
        show-line-numbers = true;
        style-scheme = "builder-dark";
        style-variant = "dark";
        tab-width = "uint32 2";
        use-system-font = false;
      };

      "org/gnome/desktop/background" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri =
          "file:///home/maxhero/.local/share/backgrounds/2022-05-06-22-36-09-.wallpaper.png";
        picture-uri-dark =
          "file:///home/maxhero/.local/share/backgrounds/2022-05-06-22-36-09-.wallpaper.png";
        primary-color = "#000000000000";
        secondary-color = "#000000000000";
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        cursor-theme = "Adwaita";
        font-antialiasing = "grayscale";
        font-hinting = "slight";
        gtk-theme = "Orchis-dark";
        icon-theme = "Tela-circle-dark";
        text-scaling-factor = 1.0;
      };

      "org/gnome/eog/view" = {
        background-color = "rgb(0,0,0)";
        use-background-color = true;
      };
    };

    # TODO: Find out why this import is causing problems.
    # This import is necessary to get NUR working
    # NUR is necessary to install firefox-addons like bitwarden
    # import = (lib.attrValues nur.repos.moredhel.hmModules.modules);
    programs.firefox = {
      enable = true;
      profiles = {
        "mindlab" = {
          id = 1;
          name = "mindlab";
          isDefault = false;
          # extensions = with nur.repos.rycee.firefox-addons; [
          #   bitwarden
          #   1password-onepassword-password-manager
          # ];
        };
        "p" = {
          id = 0;
          name = "p";
          isDefault = true;
          # extensions = with nur.repos.rycee.firefox-addons; [
          #   bitwarden
          # ];
        };
      };
    };

    programs.alacritty = {
      enable = true;
      settings.shell.program = lib.mkForce "${pkgs.fish}/bin/fish";
    };

    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        inherit modifier terminal;
        assigns = { };
        bars = [];
        colors = { };
        focus.followMouse = true;
        fonts = {
          names = [ "scientifica" ];
          size = 8.0;
        };
        # gaps = { };
        keybindings = i3AndSwayKeybindings;
        floating.criteria = i3FloatingCriteria;
        window = i3Window;
        modes = lib.mkOptionDefault { "command_mode" = commandMode; };
        # Could be the same as sway if I find tools/daemons that are compatible with both Xorg and Wayland
        startup = [
          { command = "--no-startup-id ${pkgs.dunst}/bin/dunst"; }
          { command = "--no-startup-id \"killall eww && ${pkgs.eww}/bin/eww daemon && ${pkgs.eww}/bin/eww open bar-left && ${pkgs.eww}/bin/eww open bar-right\""; always = true; }
          { command = "--no-startup-id ${pkgs.ibus}/bin/ibus-daemon --daemonize"; }
          { command = "--no-startup-id ${pkgs.feh}/bin/feh --bg-fill ~/.wallpaper.jpg"; }
          { command = "--no-startup-id ${nm-applet} --indicator"; }
          { command = "--no-startup-id ${clipman}"; }
        ];
      };
    };

    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true; # so that gtk works properly
      wrapperFeatures.base = true; # so that gtk works properly
      xwayland = true;
      config = {
        inherit modifier terminal menu;
        floating.modifier = modifier;
        bars = [ ];
        focus.followMouse = "yes";
        keybindings = i3AndSwayKeybindings;
        window = swayWindow;
        floating.criteria = swayFloatingCriteria;
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
        modes = lib.mkOptionDefault { "command_mode" = commandMode; };
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

    programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
      extensions = [{ id = "nngceckbapebfimnlniiiahkandclblb"; }];
    };

    programs.mpv = {
      enable = true;
      config = {
        alang = "jpn,eng";
        slang = "jpn,eng";
        audio-channels = "stereo";
        ytdl-format = "bestvideo[height<=?1440]+bestaudio/best";
      };
    };

    services.blueman-applet.enable = true;
    services.mpd-discord-rpc.enable = true;
    services.network-manager-applet.enable = true;
    services.playerctld.enable = true;
    services.swayidle.enable = true;
    services.picom.enable = true;

    gtk = {
      cursorTheme.name = "Adwaita";
      iconTheme.package = pkgs.tela-circle-icon-theme;
    };
    programs.obs-studio.enable = true;
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
    };
    programs.zathura.enable = true;

    # Create Firefox .desktop for each profile
    xdg = {
      desktopEntries = {
        "reboot" = {
          name = "Reboot";
          exec = "${lxqt-sudo} reboot";
          icon =
            "${pkgs.tela-circle-icon-theme}/share/icons/Tela-circle-dark/scalable@2x/apps/xfsm-reboot.svg";
          terminal = false;
        };
        "windows" = {
          name = "Windows";
          exec = "sudo ${(pkgs.callPackage (self + /pkgs/reboot-to-windows.nix) {})}/bin/reboot-to-windows";
          icon =
            "${pkgs.tela-circle-icon-theme}/share/icons/Tela-circle-dark/scalable@2x/apps/xfsm-reboot.svg";
          terminal = false;
        };
        "discord" = {
          name = "Discord (XWayland)";
          exec = "nowl ${discord}";
          icon = "${pkgs.discord}/share/icons/hicolor/256x256/apps/discord.png";
          terminal = false;
          categories = [ "Application" "Network" ];
        };
        "firefox-mindlab" = {
          name = "Firefox (Wayland - Profile: MindLab)";
          genericName = "Web Browser";
          exec = "${firefox} -p mindlab %U";
          terminal = false;
          icon = "firefox";
          categories = [ "Application" "Network" "WebBrowser" ];
          type = "Application";
        };
        "firefox" = {
          name = "Firefox (Wayland)";
          genericName = "Web Browser";
          exec = "${firefox} %U";
          terminal = false;
          icon = "firefox";
          categories = [ "Application" "Network" "WebBrowser" ];
          mimeType = [
            "application/pdf"
            "application/vnd.mozilla.xul+xml"
            "application/xhtml+xml"
            "text/html"
            "text/xml"
            "x-scheme-handler/http"
            "x-scheme-handler/https"
          ];
          type = "Application";
        };
      };
    };
    xdg.configFile."waybar/config".text = ''
      {
          "layer": "top",
          "position": "top",
          "modules-left": [
              "sway/workspaces",
              "custom/right-arrow-dark"
          ],
          "modules-center": [
              "custom/left-arrow-dark",
              "clock#1",
              "custom/left-arrow-light",
              "custom/left-arrow-dark",
              "clock#2",
              "custom/right-arrow-dark",
              "custom/right-arrow-light",
              "clock#3",
              "custom/right-arrow-dark"
          ],
          "modules-right": [
              "custom/left-arrow-dark",
              "pulseaudio",
              "custom/left-arrow-light",
              "custom/left-arrow-dark",
              "memory",
              "custom/left-arrow-light",
              "custom/left-arrow-dark",
              "cpu",
              "custom/left-arrow-light",
              "custom/left-arrow-dark",
              "disk",
              "custom/left-arrow-light",
              ${battery}
              "custom/left-arrow-dark",
              "tray"
          ],
          "custom/events": {
              "format": "{}",
              "tooltip": true,
              "interval": 300,
              "format-icons": {
              "default": ""
              },
              "exec": "waybar-khal.py",
              "return-type": "json"
          },
          "custom/weather": {
              "format": "{}",
              "tooltip": true,
              "interval": 3600,
              "exec": "waybar-wttr.py",
              "return-type": "json"
          },
          "custom/gpu-usage": {
          "exec": "radeontop -d --limit 1 -i 4 - | cut -c 32-35 -",
          "format": "GPU {}%",
          "tooltip": false,
          "return-type": "",
          "interval": 4
          },
          "custom/left-arrow-dark": {
              "format": "",
              "tooltip": false
          },
          "custom/left-arrow-light": {
              "format": "",
              "tooltip": false
          },
          "custom/right-arrow-dark": {
              "format": "",
              "tooltip": false
          },
          "custom/right-arrow-light": {
              "format": "",
              "tooltip": false
          },

          "sway/workspaces": {
            "disable-scroll": false,
            "format": "{icon}",
            "format-icons": {
                "1": "一",
                "2": "二",
                "3": "三",
                "4": "四",
                "5": "五",
                "6": "六",
                "7": "七",
                "8": "八",
                "9": "九",
                "10": "十",
                "11": "十一",
                "12": "十二",
                "13": "十三",
                "14": "十四",
                "15": "十五",
                "16": "十六",
                "17": "十七",
                "18": "十八",
                "19": "十九",
                "20": "二十",
                "21": "二十一",
                "22": "二十二",
                "23": "二十三",
                "24": "二十四",
                "25": "二十五",
                "26": "二十六",
                "27": "二十七",
                "28": "二十八",
                "29": "二十九",
                "30": "三十",
                "31": "三十一",
                "32": "三十二",
                "33": "三十三",
                "34": "三十四",
                "35": "三十五",
                "36": "三十六",
                "37": "三十七",
                "38": "三十八",
                "39": "三十九",
                "40": "四十",
                "41": "四十一",
                "42": "四十二",
                "43": "四十三",
                "44": "四十四",
                "45": "四十五",
                "46": "四十六",
                "47": "四十七",
                "48": "四十八",
                "49": "四十九",
                "50": "五十",
                "51": "五十一",
                "52": "五十二",
                "53": "五十三",
                "54": "五十四",
                "55": "五十五",
                "56": "五十六",
                "57": "五十七",
                "58": "五十八",
                "59": "五十九",
                "60": "六十",
                "61": "六十一",
                "62": "六十二",
                "63": "六十三",
                "64": "六十四",
                "65": "六十五",
                "66": "六十六",
                "67": "六十七",
                "68": "六十八",
                "69": "六十九",
                "70": "七十",
                "71": "七十一",
                "72": "七十二",
                "73": "七十三",
                "74": "七十四",
                "75": "七十五",
                "76": "七十六",
                "77": "七十七",
                "78": "七十八",
                "79": "七十九",
                "80": "八十",
                "81": "八十一",
                "82": "八十二",
                "83": "八十三",
                "84": "八十四",
                "85": "八十五",
                "86": "八十六",
                "87": "八十七",
                "88": "八十八",
                "89": "八十九",
                "90": "九十",
                "91": "九十一",
                "92": "九十二",
                "93": "九十三",
                "94": "九十四",
                "95": "九十五",
                "96": "九十六",
                "97": "九十七",
                "98": "九十八",
                "99": "九十九",
                "100": "百"
              }
          },

          "clock#1": {
              "format": "{:%a}",
              "tooltip": false
          },
          "clock#2": {
              "format": "{:%H:%M}",
              "tooltip": false
          },
          "clock#3": {
              "format": "{:%y-%m-%d}",
              "tooltip": false
          },

          "pulseaudio": {
              "format": "{icon} {volume:2}%",
              "format-bluetooth": "{icon}  {volume}%",
              "format-muted": "MUTE",
              "format-icons": {
                  "headphones": "",
                  "default": [
                      "",
                      ""
                  ]
              },
              "scroll-step": 5,
              "on-click": "pamixer -t",
              "on-click-right": "pavucontrol"
          },
          "memory": {
              //"interval": 5,
              //"format": "Mem {}%"
              "interval": 30,
              "format": "{used:0.1f}G/{total:0.1f}G "
          },
          "cpu": {
              "interval": 5,
              "format": "CPU {usage:2}%"
          },
          "battery": {
              "states": {
                  "good": 95,
                  "warning": 30,
                  "critical": 15
              },
              "format": "{icon} {capacity}%",
              "format-icons": [
                  "",
                  "",
                  "",
                  "",
                  ""
              ]
          },
          "disk": {
              "interval": 5,
              "format": "Disk {percentage_used:2}%",
              "path": "/"
          },
          "tray": {
              "icon-size": 24
          }
      }
    '';
    xdg.configFile."waybar/modules".source = self + /home/maxhero/graphical-interface/waybar/modules;
    programs.bash.profileExtra = ''
      export GTK_THEME='${gtkTheme}'
      export GTK_ICON_THEME='${iconTheme}'
      export GTK2_RC_FILES='${gtk2-rc-files}'
      export QT_STYLE_OVERRIDE='gtk2'

      # KDE/Plasma platform for Qt apps.
      export QT_QPA_PLATFORMTHEME='kde'
      export QT_PLATFORM_PLUGIN='kde'
      export QT_PLATFORMTHEME='kde'
    '';
    programs.waybar.style = ''
      * {
          font-size: ${toString fontSize}px;
          font-family: scientifica, dina;
      }

      window#waybar {
          background: #303030;
          color: #fdf6e3;
      }

      #custom-right-arrow-dark,
      #custom-left-arrow-dark {
          color: #1a1a1a;
      }
      #custom-right-arrow-light,
      #custom-left-arrow-light {
          color: #292b2e;
          background: #101010;
      }

      #workspaces,
      #clock.1,
      #clock.2,
      #clock.3,
      #pulseaudio,
      #custom-gpu-usage,
      #custom-weather,
      #custom-events,
      #memory,
      #cpu,
      #battery,
      #disk,
      #tray {
          background: #101010;
      }

      #workspaces button {
          padding: 0 2px;
          color: #fdf6e3;
      }
      #workspaces button.focused {
          color: #268bd2;
      }
      #workspaces button:hover {
          box-shadow: inherit;
          text-shadow: inherit;
      }
      #workspaces button:hover {
          background: #101010;
          border: #1a1a1a;
          padding: 0 4px;
      }

      #pulseaudio {
          color: #268bd2;
      }

      #custom-gpu-usage {
          color: #00ff00;
      }

      #memory {
          color: #2aa198;
      }
      #cpu {
          color: #6c71c4;
      }
      #battery {
          color: #859900;
      }
      #disk {
          color: #b58900;
      }

      #clock,
      #pulseaudio,
      #memory,
      #cpu,
      #battery,
      #disk {
          padding: 4px 16px;
      }
    '';

    xdg.configFile."waybar.sh" = {
      text = ''
        #!${pkgs.bash}/bin/bash
        # Terminate already running bar instances
        killall -q ${waybar}
        killall -q .waybar-wrapped

        # Wait until the processes have been shut down
        while pgrep -x ${waybar} >/dev/null; do sleep 1; done
        # Launch main
        ${waybar}
      '';
      executable = true;
    };

    xdg.configFile."waybar/mediaplayer.py" = {
      source = self + /home/maxhero/graphical-interface/waybar/mediaplayer.py;
      executable = true;
    };

    xdg.configFile."waybar/waybar-khal.py" = {
      source = self + /home/maxhero/graphical-interface/waybar/waybar-khal.py;
      executable = true;
    };

    xdg.configFile."waybar/waybar-wttr.py" = {
      source = self + /home/maxhero/graphical-interface/waybar/waybar-wttr.py;
      executable = true;
    };

    xdg.configFile."wofi/style.css".text = ''
      window {
      margin: 0px;
      border: 1px solid #fb246f;
      background-color: #272822;
      }

      #input {
      margin: 5px;
      border: none;
      color: #a0e300;
      background-color: #32332b;
      }

      #inner-box {
      margin: 5px;
      border: none;
      background-color: #272822;
      }

      #outer-box {
      margin: 5px;
      border: none;
      background-color: #272822;
      }

      #scroll {
      margin: 0px;
      border: none;
      }

      #text {
      margin: 5px;
      border: none;
      color: #f8f8f2;
      }

      #entry:selected {
      background-color: #32332b;
      }
    '';
    ewwConfig.enable = true;
    rofiConfig = {
      enable = true;
      style = 1;
      type = 6;
      color = "onedark";
    };

    xdg.configFile.pcmanfm = {
      target = "pcmanfm-qt/default/settings.conf";
      text = lib.generators.toINI { } {
        Behavior = {
          NoUsbTrash = true;
          SingleWindowMode = true;
        };
        System = {
          Archiver = "xarchiver";
          FallbackIconThemeName = iconTheme;
          Terminal = "${terminal}";
          SuCommand = "${lxqt-sudo} %s";
        };
        Thumbnail = { ShowThumbnails = true; };
        Volume = {
          AutoRun = false;
          CloseOnUnmount = true;
          MountOnStartup = false;
          MountRemovable = false;
        };
      };

    };

    home.file = {
      ".anthy".source = self + /home/maxhero/graphical-interface/.anthy;
      ".wallpaper.jpg".source = self + /home/maxhero/graphical-interface/.wallpaper.jpg;
    };

    xdg = {
      # Need to solve this later for better looking stuff
      mimeApps = {
        enable = true;
        defaultApplications = {
          "image/png" = "org.nomacs.ImageLounge.desktop";
          "image/jpeg" = "org.nomacs.ImageLounge.desktop";
          "application/pdf" = "firefox.desktop";
          "application/ogg" = "mpv.desktop";
          "application/x-ogg" = "mpv.desktop";
          "application/mxf" = "mpv.desktop";
          "application/sdp" = "mpv.desktop";
          "application/smil" = "mpv.desktop";
          "application/x-smil" = "mpv.desktop";
          "application/streamingmedia" = "mpv.desktop";
          "application/x-streamingmedia" = "mpv.desktop";
          "application/vnd.rn-realmedia" = "mpv.desktop";
          "application/vnd.rn-realmedia-vbr" = "mpv.desktop";
          "audio/aac" = "mpv.desktop";
          "audio/x-aac" = "mpv.desktop";
          "audio/vnd.dolby.heaac.1" = "mpv.desktop";
          "audio/vnd.dolby.heaac.2" = "mpv.desktop";
          "audio/aiff" = "mpv.desktop";
          "audio/x-aiff" = "mpv.desktop";
          "audio/m4a" = "mpv.desktop";
          "audio/x-m4a" = "mpv.desktop";
          "application/x-extension-m4a" = "mpv.desktop";
          "audio/mp1" = "mpv.desktop";
          "audio/x-mp1" = "mpv.desktop";
          "audio/mp2" = "mpv.desktop";
          "audio/x-mp2" = "mpv.desktop";
          "audio/mp3" = "mpv.desktop";
          "audio/x-mp3" = "mpv.desktop";
          "audio/mpeg" = "mpv.desktop";
          "audio/mpeg2" = "mpv.desktop";
          "audio/mpeg3" = "mpv.desktop";
          "audio/mpegurl" = "mpv.desktop";
          "audio/x-mpegurl" = "mpv.desktop";
          "audio/mpg" = "mpv.desktop";
          "audio/x-mpg" = "mpv.desktop";
          "audio/rn-mpeg" = "mpv.desktop";
          "audio/musepack" = "mpv.desktop";
          "audio/x-musepack" = "mpv.desktop";
          "audio/ogg" = "mpv.desktop";
          "audio/scpls" = "mpv.desktop";
          "audio/x-scpls" = "mpv.desktop";
          "audio/vnd.rn-realaudio" = "mpv.desktop";
          "audio/wav" = "mpv.desktop";
          "audio/x-pn-wav" = "mpv.desktop";
          "audio/x-pn-windows-pcm" = "mpv.desktop";
          "audio/x-realaudio" = "mpv.desktop";
          "audio/x-pn-realaudio" = "mpv.desktop";
          "audio/x-ms-wma" = "mpv.desktop";
          "audio/x-pls" = "mpv.desktop";
          "audio/x-wav" = "mpv.desktop";
          "video/mpeg" = "mpv.desktop";
          "video/x-mpeg2" = "mpv.desktop";
          "video/x-mpeg3" = "mpv.desktop";
          "video/mp4v-es" = "mpv.desktop";
          "video/x-m4v" = "mpv.desktop";
          "video/mp4" = "mpv.desktop";
          "application/x-extension-mp4" = "mpv.desktop";
          "video/divx" = "mpv.desktop";
          "video/vnd.divx" = "mpv.desktop";
          "video/msvideo" = "mpv.desktop";
          "video/x-msvideo" = "mpv.desktop";
          "video/ogg" = "mpv.desktop";
          "video/quicktime" = "mpv.desktop";
          "video/vnd.rn-realvideo" = "mpv.desktop";
          "video/x-ms-afs" = "mpv.desktop";
          "video/x-ms-asf" = "mpv.desktop";
          "audio/x-ms-asf" = "mpv.desktop";
          "application/vnd.ms-asf" = "mpv.desktop";
          "video/x-ms-wmv" = "mpv.desktop";
          "video/x-ms-wmx" = "mpv.desktop";
          "video/x-ms-wvxvideo" = "mpv.desktop";
          "video/x-avi" = "mpv.desktop";
          "video/avi" = "mpv.desktop";
          "video/x-flic" = "mpv.desktop";
          "video/fli" = "mpv.desktop";
          "video/x-flc" = "mpv.desktop";
          "video/flv" = "mpv.desktop";
          "video/x-flv" = "mpv.desktop";
          "video/x-theora" = "mpv.desktop";
          "video/x-theora+ogg" = "mpv.desktop";
          "video/x-matroska" = "mpv.desktop";
          "video/mkv" = "mpv.desktop";
          "audio/x-matroska" = "mpv.desktop";
          "application/x-matroska" = "mpv.desktop";
          "video/webm" = "mpv.desktop";
          "audio/webm" = "mpv.desktop";
          "audio/vorbis" = "mpv.desktop";
          "audio/x-vorbis" = "mpv.desktop";
          "audio/x-vorbis+ogg" = "mpv.desktop";
          "video/x-ogm" = "mpv.desktop";
          "video/x-ogm+ogg" = "mpv.desktop";
          "application/x-ogm" = "mpv.desktop";
          "application/x-ogm-audio" = "mpv.desktop";
          "application/x-ogm-video" = "mpv.desktop";
          "application/x-shorten" = "mpv.desktop";
          "audio/x-shorten" = "mpv.desktop";
          "audio/x-ape" = "mpv.desktop";
          "audio/x-wavpack" = "mpv.desktop";
          "audio/x-tta" = "mpv.desktop";
          "audio/AMR" = "mpv.desktop";
          "audio/ac3" = "mpv.desktop";
          "audio/eac3" = "mpv.desktop";
          "audio/amr-wb" = "mpv.desktop";
          "video/mp2t" = "mpv.desktop";
          "audio/flac" = "mpv.desktop";
          "audio/mp4" = "mpv.desktop";
          "application/x-mpegurl" = "mpv.desktop";
          "video/vnd.mpegurl" = "mpv.desktop";
          "application/vnd.apple.mpegurl" = "mpv.desktop";
          "audio/x-pn-au" = "mpv.desktop";
          "video/3gp" = "mpv.desktop";
          "video/3gpp" = "mpv.desktop";
          "video/3gpp2" = "mpv.desktop";
          "audio/3gpp" = "mpv.desktop";
          "audio/3gpp2" = "mpv.desktop";
          "video/dv" = "mpv.desktop";
          "audio/dv" = "mpv.desktop";
          "audio/opus" = "mpv.desktop";
          "audio/vnd.dts" = "mpv.desktop";
          "audio/vnd.dts.hd" = "mpv.desktop";
          "audio/x-adpcm" = "mpv.desktop";
          "application/x-cue" = "mpv.desktop";
          "audio/m3u" = "mpv.desktop";
          "x-scheme-handler/http" = defaultBrowser;
          "x-scheme-handler/https" = defaultBrowser;
          "x-scheme-handler/chrome" = defaultBrowser;
          "text/html" = defaultBrowser;
          "application/x-extension-htm" = defaultBrowser;
          "application/x-extension-html" = defaultBrowser;
          "application/x-extension-shtml" = defaultBrowser;
          "application/xhtml+xml" = defaultBrowser;
          "application/x-extension-xhtml" = defaultBrowser;
          "application/x-extension-xht" = defaultBrowser;
        };
      };
    };
  };
}
