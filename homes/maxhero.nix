{ config, pkgs, lib, home-manager, nix-doom-emacs, ... }:
with pkgs.lib;
let
  modifier = "Mod4";
  modifier2 = "Mod1";
  gtkTheme = "Orchis-Dark";
  iconTheme = "Tela-circle-dark";
  terminal = "${pkgs.alacritty}/bin/alacritty";
  menu = "${pkgs.wofi}/bin/wofi -I";
  defaultBrowser = "firefox.desktop";
  lock =
    "~/.config/sway/lock.sh --indicator --indicator-radius 100 --ring-color e40000 --clock";
in {
  #imports = [
  #  nix-doom-emacs.hmModule
  #];

  home.username = "maxhero";
  home.homeDirectory = "/home/maxhero";

  #fonts.fontconfig.enable = true;

  home.language = {
    base = "en_GB.UTF-8";
    time = "pt_BR.UTF-8";
    monetary = "pt_BR.UTF-8";
    numeric = "pt_BR.UTF-8";
  };

  home.file.".zshrc".source = "./.zshrc";
  home.file.".anthy".source = "./.anthy";
  home.file.".wallpaper.png".source = "./.wallpaper.png";
  home.file."$XDG_CONFIG_HOME/waybar".source = "waybar";

  # I need to setup an IME soon
  #i18n.inputMethod = {
  #  enabled = "ibus";
  #  ibus.engines = with pkgs.ibus-engines; [ mozc ];
  #};

  programs.git = {
    enable = true;
    userName = "Marcelo Amancio de Lima Santos";
    userEmail = "contact@maxhero.dev";
    extraConfig = {
      rerere.enabled = true;
      pull.rebase = true;
      tag.gpgsign = true;
      init.defaultBranch = "master";
      core = {
        excludesfile = "$NIXOS_CONFIG_DIR/scripts/gitignore";
        editor = "${pkgs.emacs}/bin/emacs";
      };
    };
  };

  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
    settings = {
      window.opacity = 0.8;
      font = {
        size = 16;
        normal.family = "scientifica";
        bold.family = "scientifica";
        italic.family = "scientifica";
        bold_italic = {
          family = "scientifica";
          size = 9.0;
        };
      };
      shell.program = "${pkgs.zsh}/bin/zsh";
    };
  };

  programs.aria2.enable = true;

  programs.bat = {
    enable = true;
    # Need to check what is going on here
    # themes = {
    #  monokai = builtins.readFile (pkgs.fetchFromGitHub {
    #    owner = "fnordfish";
    #    repo = "MonokaiMD.tmTheme";
    #    rev = "34ec6dc3c96d8155f4a17e1bd3edf43d27feb344";
    #    sha256 = "1x6kjcf91zvkvbssd922k77xmmi56ik2938rvfcs7y3w09nis3l7";
    #  } + "/MonokaiMD.tmTheme");
    # };
  };

  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };

  programs.firefox = {
    enable = true;
    profiles = {
      "tlb" = {
        id = 1;
        name = "tlb";
        isDefault = false;
      };
      "dea" = {
        id = 2;
        name = "dea";
        isDefault = false;
      };
      "p" = {
        id = 0;
        name = "p";
        isDefault = true;
      };
    };
  };

  programs.fish.enable = true;

  programs.command-not-found.enable = true;

  #programs.doom-emacs = {
  #  enable = true;
  #  doomPrivateDir = ./doom.d;
  #};

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };

  programs.home-manager.enable = true;

  programs.jq.enable = true;

  programs.lsd = {
    enable = true;
    enableAliases = true;
  };

  programs.man = {
    enable = true;
    generateCaches = true;
  };

  programs.mangohud = {
    enable = true;
    settings = {
      arch = true;
      background_alpha = "0.05";
      battery = true;
      cpu_temp = true;
      engine_version = true;
      font_size = 17;
      gl_vsync = -1;
      gpu_temp = true;
      io_read = true;
      io_write = true;
      position = "top-right";
      round_corners = 8;
      vram = true;
      vsync = 0;
      vulkan_driver = true;
      width = 260;
      wine = true;
    };
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

  programs.mu.enable = true;

  #programs.nushell.enable = true;

  programs.obs-studio = { enable = true; };

  programs.ssh.enable = true;

  programs.tealdeer.enable = true;

  programs.tmux.enable = true;

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    #settings = {
    #};
    #style = {
    #};
  };

  programs.zathura.enable = true;

  programs.zsh.oh-my-zsh.enable = true;

  services.blueman-applet.enable = true;

  #services.gpg-agent.enable = true;

  services.mpd-discord-rpc.enable = true;

  services.network-manager-applet.enable = true;

  services.playerctld.enable = true;

  services.swayidle = {
    enable = true;
    #timeouts = {};
  };

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

  gtk = {
    cursorTheme.name = "Adwaita";
    iconTheme.package = tela-circle-icon-theme;
  };

  home.packages = with pkgs; [
    swaynotificationcenter
    sway-launcher-desktop
    orchis-theme
    tela-circle-icon-theme
    tenacity
  ];

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
        "XF86AudioRaiseVolume" = "exec ${pkgs.avizo}/bin/volumectl -u up";
        "XF86AudioLowerVolume" = "exec ${pkgs.avizo}/bin/volumectl -u down";
        "XF86AudioMute" = "exec ${pkgs.avizo}/bin/volumectl toggle-mute";

        # Lightweight screenshot to cliboard and temporary file
        "Print" =
          "exec ${pkgs.grim}/bin/grim -t png -g \"$(${pkgs.slurp}/bin/slurp)\" - | tee /tmp/screenshot.png | ${pkgs.wl-clipboard}/bin/wl-copy -t 'image/png'";

        # Notifications tray
        "${modifier}+Shift+n" =
          "exec ${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";

        # Enter my extra modes
        "${modifier}+c" = "mode command_mode";

        # Navigation Between Workspaces
        "${modifier}+${modifier2}+left" = "workspace prev";
        "${modifier}+${modifier2}+right" = "workspace next";

        # Reload/Restart
        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "restart";

        "${modifier}+${modifier2}+v" = "split v";
        "${modifier}+${modifier2}+h" = "split h";

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
        "${modifier}+${modifier2}+1" = "workspace 11";
        "${modifier}+${modifier2}+2" = "workspace 12";
        "${modifier}+${modifier2}+3" = "workspace 13";
        "${modifier}+${modifier2}+4" = "workspace 14";
        "${modifier}+${modifier2}+5" = "workspace 15";
        "${modifier}+${modifier2}+6" = "workspace 16";
        "${modifier}+${modifier2}+7" = "workspace 17";
        "${modifier}+${modifier2}+8" = "workspace 18";
        "${modifier}+${modifier2}+9" = "workspace 19";
        "${modifier}+${modifier2}+0" = "workspace 20";
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
        "${modifier}+${modifier2}+Shift+1" = "move container to workspace 11";
        "${modifier}+${modifier2}+Shift+2" = "move container to workspace 12";
        "${modifier}+${modifier2}+Shift+3" = "move container to workspace 13";
        "${modifier}+${modifier2}+Shift+4" = "move container to workspace 14";
        "${modifier}+${modifier2}+Shift+5" = "move container to workspace 15";
        "${modifier}+${modifier2}+Shift+6" = "move container to workspace 16";
        "${modifier}+${modifier2}+Shift+7" = "move container to workspace 17";
        "${modifier}+${modifier2}+Shift+8" = "move container to workspace 18";
        "${modifier}+${modifier2}+Shift+9" = "move container to workspace 19";
        "${modifier}+${modifier2}+Shift+0" = "move container to workspace 20";

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
        DP-2 = {
          pos = "0 0";
          mode = "3840x2160@60.000000hz";
        };
        DP-3 = {
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
        {
          command = "${pkgs.swaynotificationcenter}/bin/swaync";
        }
        # { command = "~/.config/waybar/waybar.sh"; }
        { command = "nm-applet --indicator"; }
        {
          command = "clipman";
        }
        # { command = "ibus-daemon -drxr"; }
        # { command = "ibus engine mozc-jp"; }
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
      export GTK_ICON_THEME='Tela-circle-dark'
      export GTK2_RC_FILES='${pkgs.orchis-theme}/share/themes/${gtkTheme}/gtk-2.0/gtkrc'
      export QT_STYLE_OVERRIDE='gtk2'

      # KDE/Plasma platform for Qt apps.
      export QT_QPA_PLATFORMTHEME='kde'
      export QT_PLATFORM_PLUGIN='kde'
      export QT_PLATFORMTHEME='kde'
    '';
  };
  xdg = {
    # Need to solve this later for better looking stuff
    configFile = {
      pcmanfm = {
        target = "pcmanfm-qt/default/settings.conf";
        text = generators.toINI { } {
          Behavior = {
            NoUsbTrash = true;
            SingleWindowMode = true;
          };
          System = {
            Archiver = "xarchiver";
            FallbackIconThemeName = iconTheme;
            Terminal = "${terminal}";
            SuCommand = "${pkgs.lxqt.lxqt-sudo}/bin/lxqt-sudo %s";
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
    };
    desktopEntries = {
      "firefox-tlb" = {
        name = "Firefox (TLB)";
        genericName = "Web Browser";
        exec = "${pkgs.firefox}/bin/firefox -p tlb %U";
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
      "firefox-dea" = {
        name = "Firefox (DEA)";
        genericName = "Web Browser";
        exec = "${pkgs.firefox}/bin/firefox -p dea %U";
        terminal = false;
        categories = [ "Application" "Network" "WebBrowser" ];
        icon = "firefox";
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
      "firefox" = {
        name = "Firefox (Wayland)";
        genericName = "Web Browser";
        exec = "${pkgs.firefox}/bin/firefox %U";
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
      "discord" = {
        name = "Discord (XWayland)";
        exec = "nowl ${pkgs.discord}/bin/discord";
        terminal = false;
        categories = [ "Application" "Network" ];
      };
    };
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
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "$HOME/Desktop";
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      pictures = "$HOME/Pictures";
      publicShare = "$HOME/Public";
      templates = "$HOME/Templates";
      videos = "$HOME/Videos";
      music = "$HOME/Music";
    };
  };
  home.stateVersion = "21.11";
}
