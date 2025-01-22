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
      wootility
      discord-canary
      vesktop
      ffmpegthumbnailer
      flameshot
      adwaita-icon-theme
      eog
      lxqt.pavucontrol-qt
      lxqt.pcmanfm-qt
      ticktick
      pamixer
      qbittorrent
      slack
      spotify
      tdesktop
      zoom-us
      notion-app-enhanced
      gimp
      radeontop
      filezilla
      gparted
      gnome-tweaks
      orchis-theme
      xfce.thunar
      tela-circle-icon-theme
      ddcutil
      obsidian
      pomodoro
      xarchiver
      cage
    ];

    nixpkgs.config = {
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
    services.libinput.mouse.accelSpeed = "0.0";
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
