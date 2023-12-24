{ self, config, pkgs, lib, home-manager, nur, nix-doom-emacs, ... }@attrs:
let
  cfg = config.graphical-interface;
  env = import (self + /env) attrs;
  enableI3WM = builtins.elem "i3" cfg.environments;
in
{
  options.graphical-interface = {
    enable = lib.mkEnableOption "Enable Development Module";
    environments = lib.mkOption {
      type = with lib.types; listOf str;
      description = "Enable envs Graphical Interface Modules";
      default = ["i3"];
    };
  };
  config = lib.mkIf cfg.enable {
    services.xserver.windowManager.i3 = lib.mkIf enableI3WM {
      enable = true;
      package = pkgs.i3-gaps;
    };
    systemd.targets."i3-session" = lib.mkIf enableI3WM {
      enable = true;
      description = "i3 session";
      bindsTo = [ "graphical-session.target" ];
    };
    boot.plymouth = {
      enable = true;
    };
    environment.systemPackages = with pkgs; [
      alacritty
      kitty
      discord-canary
      ffmpegthumbnailer
      gnome.adwaita-icon-theme
      gnome.eog
      lxqt.pavucontrol-qt
      lxqt.pcmanfm-qt
      pamixer
      qbittorrent
      slack
      spotify
      tdesktop
      #zoom-us
      wdisplays
      notion-app-enhanced
      gimp
      radeontop
      filezilla
      gparted
      gnome.gnome-tweaks
      orchis-theme
      libsForQt5.dolphin
      libsForQt5.dolphin-plugins
      tela-circle-icon-theme
      ddcutil
      whatsapp-for-linux
      pidgin-with-plugins
      rambox
      gnome.pomodoro
      #xarchiver
    ];

    nixpkgs.config.packageOverrides = pkgs: rec {
      pidgin-with-plugins = pkgs.pidgin.override {
        plugins = with pkgs; [
          pidgin-skypeweb
          pidgin-opensteamworks
          purple-slack
          purple-discord
          purple-googlechat
        ];
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
    services.xserver.xkbVariant = "intl";
    services.xserver.enable = true;
  };
}
