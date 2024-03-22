{ self, config, pkgs, lib, home-manager, nix-doom-emacs, ... }@attrs:
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
      default = [ "i3" ];
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
    boot.plymouth.enable = true;
    environment.systemPackages = with pkgs; [
      alacritty
      kitty
      discord-canary
      vesktop
      ffmpegthumbnailer
      flameshot
      gnome.adwaita-icon-theme
      gnome.eog
      lxqt.pavucontrol-qt
      lxqt.pcmanfm-qt
      pamixer
      qbittorrent
      slack
      spotify
      tdesktop
      zoom-us
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
      obsidian
      gnome.pomodoro
      xarchiver
    ];

    nixpkgs.config = {
      packageOverrides = pkgs: rec {
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
      permittedInsecurePackages = [ "electron-25.9.0" ];
    };

    fonts = {
      packages = with pkgs; [
        sarasa-gothic
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
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
      fontDir.enable = true;
      fontconfig.allowBitmaps = true;
    };
    programs.dconf.enable = true;
    services.xserver.xkb.layout = "us";
    services.xserver.xkb.variant = "intl";
    services.xserver.enable = true;
    environment.variables = {
      DefaultIMModule = "uim";
      XMODIFIERS = "@im=uim";
      XMODIFIER = "@im=uim";
      QT_IM_MODULE = "uim";
      GTK_IM_MODULE = "uim";
      GLFW_IM_MODULE = "uim";
    };
  };
}
