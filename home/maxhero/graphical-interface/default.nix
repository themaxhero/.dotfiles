{ self, config, pkgs, lib, specialArgs, nur, ... }:
with specialArgs;
let
  lxqt-sudo = "${pkgs.lxqt.lxqt-sudo}/bin/lxqt-sudo";
  nm-applet = "${pkgs.networkmanagerapplet}/bin/nm-applet";
  isUchigatana = nixosConfig.networking.hostName == "uchigatana";
  fontSize = if isUchigatana then 16 else 24;
in
{
  home = {
    packages = with pkgs; [
      anki
      veracrypt
      brave
      bitwarden-desktop
      orchis-theme
      #tela-circle-icon-theme
      i3-resurrect
      yt-dlp
      sublime
      nomacs
      yacreader
      i3status-rust
    ];
    file = {
      ".anthy".source = self + /home/maxhero/graphical-interface/.anthy;
      ".uim.d".source = ./.uim.d;
      ".wallpaper.jpg".source = self + /home/maxhero/graphical-interface/.wallpaper.jpg;
      ".wallpaper.png".source = self + /home/maxhero/graphical-interface/.wallpaper.png;
    };
  };

  services.easyeffects.enable = true;

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

  programs.kitty = {
    enable = true;
    themeFile = "Monokai_Classic";
    settings = {
      transparency = "yes";
      background_opacity = "0.95";
      confirm_os_window_close = "0";
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

  services.blueman-applet.enable = true;
  services.mpd-discord-rpc.enable = true;
  services.network-manager-applet.enable = true;
  services.playerctld.enable = true;
  services.picom = {
    enable = true;
    vSync = true;
  };

  gtk = {
    enable = true;
    cursorTheme.name = "Adwaita";
    #iconTheme = {
    #  name = "Tela-circle-dark";
    #  package = pkgs.tela-circle-icon-theme;
    #};
    theme = {
      name = "Orchis-Dark";
      package = pkgs.orchis-theme;
    };
  };

  qt = {
    enable = true;
    style.name = "adwaita-dark";
  };

  programs.obs-studio.enable = true;

  # I'm so happy that I found uim
  i18n.inputMethod.enabled = "uim";

  ewwConfig.enable = true;
  rofiConfig = {
    enable = true;
    style = 1;
    type = 6;
    color = "onedark";
  };

  xdg = {
    desktopEntries = {
      reboot = {
        name = "Reboot";
        exec = "${lxqt-sudo} reboot";
        #icon =
        #  "${pkgs.tela-circle-icon-theme}/share/icons/Tela-circle-dark/scalable@2x/apps/xfsm-reboot.svg";
        terminal = false;
      };
      windows = {
        name = "Windows";
        exec = "sudo ${(pkgs.callPackage (self + /pkgs/reboot-to-windows.nix) {})}/bin/reboot-to-windows";
        #icon =
        #  "${pkgs.tela-circle-icon-theme}/share/icons/Tela-circle-dark/scalable@2x/apps/xfsm-reboot.svg";
        terminal = false;
      };
    };

    # Need to solve this later for better looking stuff
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/epub+zip" = "xarchiver.desktop";
        "application/x-7z-compressed" = "xarchiver.desktop";
        "application/x-7z-compressed-tar" = "xarchiver.desktop";
        "application/x-ace" = "xarchiver.desktop";
        "application/x-alz" = "xarchiver.desktop";
        "application/x-arc" = "xarchiver.desktop";
        "application/x-arj" = "xarchiver.desktop";
        "application/x-brotli" = "xarchiver.desktop";
        "application/x-brotli-compressed-tar" = "xarchiver.desktop";
        "application/x-bzip" = "xarchiver.desktop";
        "application/x-bzip2" = "xarchiver.desktop";
        "application/bzip2" = "xarchiver.desktop";
        "application/x-bzip-compressed-tar" = "xarchiver.desktop";
        "application/x-bzip1" = "xarchiver.desktop";
        "application/x-bzip1-compressed-tar" = "xarchiver.desktop";
        "application/x-cabinet" = "xarchiver.desktop";
        "application/x-cbr" = "xarchiver.desktop";
        "application/x-cbz" = "xarchiver.desktop";
        "application/x-cd-image" = "xarchiver.desktop";
        "application/x-compress" = "xarchiver.desktop";
        "application/x-compressed-tar" = "xarchiver.desktop";
        "application/x-cpio" = "xarchiver.desktop";
        "application/vnd.debian.binary-package" = "xarchiver.desktop";
        "application/x-ear" = "xarchiver.desktop";
        "application/x-ms-dos-executable" = "xarchiver.desktop";
        "application/x-gtar" = "xarchiver.desktop";
        "application/x-gzip" = "xarchiver.desktop";
        "application/gzip" = "xarchiver.desktop";
        "application/x-gzpostscript" = "xarchiver.desktop";
        "application/x-java-archive" = "xarchiver.desktop";
        "application/x-lha" = "xarchiver.desktop";
        "application/x-lzh-compressed" = "xarchiver.desktop";
        "application/x-lrzip" = "xarchiver.desktop";
        "application/x-lrzip-compressed-tar" = "xarchiver.desktop";
        "application/x-lzip" = "xarchiver.desktop";
        "application/x-lzip-compressed-tar" = "xarchiver.desktop";
        "application/x-lzma" = "xarchiver.desktop";
        "application/x-lzma-compressed-tar" = "xarchiver.desktop";
        "application/x-lzop" = "xarchiver.desktop";
        "application/x-lzop-compressed-tar" = "xarchiver.desktop";
        "application/x-ms-wim" = "xarchiver.desktop";
        "application/x-rar" = "xarchiver.desktop";
        "application/x-rar-compressed" = "xarchiver.desktop";
        "application/x-rpm" = "xarchiver.desktop";
        "application/x-source-rpm" = "xarchiver.desktop";
        "application/x-rzip" = "xarchiver.desktop";
        "application/x-tar" = "xarchiver.desktop";
        "application/x-tarz" = "xarchiver.desktop";
        "application/x-stuffit" = "xarchiver.desktop";
        "application/x-war" = "xarchiver.desktop";
        "application/x-xz" = "xarchiver.desktop";
        "application/x-xz-compressed-tar" = "xarchiver.desktop";
        "application/x-zip" = "xarchiver.desktop";
        "application/x-zip-compressed" = "xarchiver.desktop";
        "application/x-zoo" = "xarchiver.desktop";
        "application/zstd" = "xarchiver.desktop";
        "application/x-zstd" = "xarchiver.desktop";
        "application/x-zstd-compressed-tar" = "xarchiver.desktop";
        "application/zip" = "xarchiver.desktop";
        "application/x-archive" = "xarchiver.desktop";
        "application/vnd.ms-cab-compressed" = "xarchiver.desktop";
        "inode/directory" = "org.kde.dolphin.desktop";
        "application/pdf" = "brave.desktop";
        "application/vnd.mozilla.xul+xml" = "brave.desktop";
        "application/xhtml+xml" = "brave.desktop";
        "text/html" = "brave.desktop";
        "text/xml" = "brave.desktop";
        "x-scheme-handler/http" = "brave.desktop";
        "x-scheme-handler/https" = "brave.desktop";
        "application/x-extension-htm" = "brave.desktop";
        "application/x-extension-html" = "brave.desktop";
        "application/x-extension-shtml" = "brave.desktop";
        "application/x-extension-xhtml" = "brave.desktop";
        "application/x-extension-xht" = "brave.desktop";
        "image/png" = "org.nomacs.ImageLounge.desktop";
        "image/jpeg" = "org.nomacs.ImageLounge.desktop";
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
        "application/vnd.anki" = "anki.desktop";
        "application/vnd.ms-excel" = "wps-office-et.desktop";
        "application/x-excel" = "wps-office-et.desktop";
        "application/excel" = "wps-office-et.desktop";
        "application/x-msexcel" = "wps-office-et.desktop";
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "";
        "application/msword" = "wps-office-wps.desktop";
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "";
        "application/mspowerpoint" = "wps-office-wpp.desktop";
        "application/vnd.ms-powerpoint" = "wps-office-wpp.desktop";
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "wps-office-wpp.desktop";
        "application/vnd.oasis.opendocument.presentation" = "wps-office-wpp.desktop";
        "application/vnd.oasis.opendocument.spreadsheet" = "wps-office-et.desktop";
        "application/vnd.oasis.opendocument.text" = "wps-office-wps.desktop";
        "text/csv" = "wps-office-et.desktop";
      };
    };
  };
}
