{ pkgs, config, lib, ... }:
let
  cfg = config.personal-computer;
  isSwayEnabled = builtins.elem "sway" cfg.desktop-environents;
  isGnomeEnabled = builtins.elem "sway" cfg.desktop-environents;
  isWaylandNecessary = builtins.any (x: builtins.elem x cfg.desktop-environents) [ "sway" "kde" "kde" ];
  nowl = (import ../../tools/nowl.nix) pkgs;
in
{
  options = {
    personal-computer = {
      enable = lib.mkEnableOption "Enable Personal Computer Features";
      widgets.battery.enable = lib.mkEnableOption "Enable Battery Widget";
      desktop-environments = lib.mkOption {
        default = [ "sway" "gnome" ];
        type = types.listOf (types.enum [
          "sway"
          "gnome"
          "kde"
          "xfce"
          "i3"
          "bspwm"
          "xmonad"
        ]);
      };
    };
  };
  config = lib.mkIf cfg.enable {
    environment.variables = {
      AE_SINK = "ALSA";
      SDL_AUDIODRIVER = "pipewire";
      ALSOFT_DRIVERS = "alsa";
    };

    hardware.pulseaudio.enable = false;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      media-session.enable = false;
      systemWide = false;
      wireplumber.enable = true;
    };
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [ rocm-opencl-icd rocm-opencl-runtime ];
    };

    programs.nm-applet.enable = true;
    programs.sway = lib.mkIf isSwayEnabled {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        swaylock
        swayidle
        swaynotificationcenter
        wl-clipboard
        libinput
        libinput-gestures
        wofi
      ];
      extraSessionCommands = ''
        # Force wayland overall.
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

        # KDE/Plasma platform for Qt apps.
        export QT_QPA_PLATFORMTHEME='kde'
        export QT_PLATFORM_PLUGIN='kde'
        export QT_PLATFORMTHEME='kde'

        export GTK_IM_MODULE='ibus'
        export QT_IM_MODULE='ibus'
        export XMODIFIERS='@im=ibus'
        export GTK_IM_MODULE='/run/current-system/sw/lib/gtk-2.0/2.10.0/immodules/im-ibus.so'
      '';
    };
    environment.systemPackages = with pkgs; [
      kitty
      discord
      ffmpegthumbnailer
      gnome.adwaita-icon-theme
      gnome.eog
      lxqt.pavucontrol-qt
      lxqt.pcmanfm-qt
      nowl
      pamixer
      qbittorrent
      slack
      spotify
      tdesktop
      wpsoffice
      zoom-us
      wdisplays
      notion-app-enhanced
      gimp
      radeontop
      filezilla
      gparted
      obsidian
      gnome.gnome-tweaks
      orchis-theme
      libsForQt5.dolphin
      libsForQt5.dolphin-plugins
      tela-circle-icon-theme
      #xarchiver
    ];

    i18n = {
      inputMethod = {
        enabled = "ibus";
        ibus.engines = with pkgs.ibus-engines; [ mozc ];
      };
    };

    fonts = {
      fonts = with pkgs; [
        cantarell-fonts
        font-awesome_4
        font-awesome_5
        freefont_ttf
        google-fonts
        liberation_ttf
        noto-fonts
        ubuntu_font_family
        scientifica
        curie
      ];
      fontconfig.allowBitmaps = true;
    };
    programs.dconf.enable = true;
    services.xserver.layout = "us";
    services.xserver.enable = true;

    xdg.portal = lib.mkIf isWaylandNecessary {
      wlr.enable = true;
      extraPortals = with pkgs;
        [
          #xdg-desktop-portal-gtk
          xdg-desktop-portal-wlr
        ];
    };
    services.udisks2.enable = true;
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.desktopManager.gnome.enable = isGnomeEnabled;
    sound.mediaKeys.enable = true;
    services.blueman.enable = true;
    services.flatpak.enable = true;
    services.minidlna = {
      enable = true;
      mediaDirs = [ "/home/upnp-shared/Media" ];
    };
    services.acpid.enable = true;
    services.aria2.enable = true;
    services.fwupd.enable = true;
    services.ntp.enable = true;
    services.tumbler.enable = true;
  };
}
