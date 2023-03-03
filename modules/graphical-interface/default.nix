{ config, pkgs, lib, home-manager, nur, nix-doom-emacs, ... }:
let
  nowl = (import ../../tools/nowl.nix) pkgs;
  cfg = config.graphical-interface;
in
{
  options.graphical-interface = {
    enable = lib.mkEnableOption "Enable Development Module";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      alacritty
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
  };
}
