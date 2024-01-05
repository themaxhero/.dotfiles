{ self, config, pkgs, nur, lib, specialArgs, ... }:
with specialArgs;
let
  firefox = "${pkgs.firefox}/bin/firefox";
  lxqt-sudo = "${pkgs.lxqt.lxqt-sudo}/bin/lxqt-sudo";
  nm-applet = "${pkgs.networkmanagerapplet}/bin/nm-applet";
  isUchigatana = nixosConfig.networking.hostName == "uchigatana";
  fontSize = if isUchigatana then 16 else 24;
  defaultBrowser = "firefox.desktop";
in
{
  config = lib.mkIf nixosConfig.graphical-interface.enable {
    # TODO: Find out why this import is causing problems.
    # This import is necessary to get NUR working
    # NUR is necessary to install firefox-addons like bitwarden
    # import = (lib.attrValues nur.repos.moredhel.hmModules.modules);
    programs.firefox = {
      enable = true;
      profiles = {
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

    services.easyeffects.enable = true;

    programs.alacritty = {
      enable = true;
      settings.shell.program = lib.mkForce "${pkgs.fish}/bin/fish";
    };

    home.packages = with pkgs; [
      veracrypt
      orchis-theme
      tela-circle-icon-theme
      youtube-dl
      sublime
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
    services.picom.enable = true;

    gtk = {
      cursorTheme.name = "Adwaita";
      iconTheme.package = pkgs.tela-circle-icon-theme;
    };
    programs.obs-studio.enable = true;
    programs.zathura.enable = true;

    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-gtk ];
    };

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
        "firefox" = {
          name = "Firefox";
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
    programs.bash.profileExtra = ''
      # Env
      ${builtins.foldl' (acc: v: "${acc}\nexport ${v.name}='${v.value}'") "" env.bash_env}
    '';
    ewwConfig.enable = true;
    rofiConfig = {
      enable = true;
      style = 1;
      type = 6;
      color = "onedark";
    };

    /*xdg.configFile.pcmanfm = {
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
    };*/

    home.file = {
      ".anthy".source = self + /home/maxhero/graphical-interface/.anthy;
      ".wallpaper.jpg".source = self + /home/maxhero/graphical-interface/.wallpaper.jpg;
      ".wallpaper.png".source = self + /home/maxhero/graphical-interface/.wallpaper.png;
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
