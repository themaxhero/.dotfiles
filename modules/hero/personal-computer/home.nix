{ pkgs, lib, ... }:
let
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
  printCmd =
    "${grim} -t png -g \"$(${slurp})\" - | tee /tmp/screenshot.png | ${wl-copy} -t 'image/png'";
  usesBattery = cfg.widgets.battery.enable;
  fontSize = if cfg.widgets.battery.enable then 16 else 24;
  waybar = "${pkgs.waybar}/bin/waybar";
in
{
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

    "org/gnome/TextEditor" = lib.mkIf isGnomeEnabled {
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

    "org/gnome/desktop/background" = lib.mkIf isGnomeEnabled {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri =
        "file:///home/maxhero/.local/share/backgrounds/2022-05-06-22-36-09-.wallpaper.png";
      picture-uri-dark =
        "file:///home/maxhero/.local/share/backgrounds/2022-05-06-22-36-09-.wallpaper.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/interface" = lib.mkIf isGnomeEnabled {
      color-scheme = "prefer-dark";
      cursor-theme = "Adwaita";
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      gtk-theme = "Orchis-dark";
      icon-theme = "Tela-circle-dark";
      text-scaling-factor = 1.0;
    };

    "org/gnome/eog/view" = lib.mkIf isGnomeEnabled {
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

  wayland.windowManager.sway = lib.mkIf isSwayEnabled (lib.mkDefault {
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

      modes = {
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
  });

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
  services.swayidle.enable = isSwayEnabled;

  gtk = {
    cursorTheme.name = "Adwaita";
    iconTheme.package = pkgs.tela-circle-icon-theme;
  };
  programs.obs-studio.enable = true;
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

  xdg.configFile."waybar/config".text = lib.mkIf isSwayEnabled {
    text = ./waybar/config.nix;
  };
  xdg.configFile."waybar/modules" = lib.mkIf isSwayEnabled {
    source = ./waybar/modules;
  };

  programs.waybar = lib.mkIf isSwayEnabled {
    enable = true;
    package = pkgs.waybar;
    style = import ./waybar/style.css.nix { inherit fontSize; };
  };

  xdg.configFile."waybar.sh" = lib.mkIf isSwayEnabled {
    text = import ./waybar/waybar.sh.nix {inherit pkgs waybar;};
    executable = true;
  };

  xdg.configFile."waybar/mediaplayer.py" = lib.mkIf isSwayEnabled {
    source = ./waybar/mediaplayer.py;
    executable = true;
  };

  xdg.configFile."waybar/waybar-khal.py" = lib.mkIf isSwayEnabled {
    source = ./waybar/waybar-khal.py;
    executable = true;
  };

  xdg.configFile."waybar/waybar-wttr.py" = lib.mkIf isSwayEnabled {
    source = ./waybar/waybar-wttr.py;
    executable = true;
  };

  xdg.configFile."wofi/style.css" = lib.mkIf isSwayEnabled {
    text = ./wofi/style.css;
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
    ".anthy".source = ./.anthy;
    ".wallpaper.png".source = ./.wallpaper.png;
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
}