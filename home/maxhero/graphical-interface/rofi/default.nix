/*
  This file is just a home-manager module to make easier to use this github repo:
  Using: https://github.com/adi1090x/rofi
*/
{ config, pkgs, lib, ... }:
let
  cfg = config.rofiConfig;
in
{
  options.rofiConfig = {
    enable = lib.mkEnableOption "Enables rofi config";
    style = lib.mkOption {
      type = lib.types.int;
    };
    type = lib.mkOption {
      type = lib.types.int;
    };
    color = lib.mkOption {
      type = lib.types.str;
    };
  };
  config = lib.mkIf cfg.enable {
    xdg.configFile."rofi/applets/share/theme.bash".text = ''
      type="$XDG_CONFIG_HOME/rofi/applets/type-${toString cfg.type}"
      style='style-${toString cfg.style}.rasi'
    '';

    xdg.configFile."rofi/applets/share/colors.rasi".text = ''
      @import "$XDG_CONFIG_HOME/rofi/colors/${cfg.color}.rasi"
    '';

    xdg.configFile."rofi/applets/share/fonts.rasi".text = ''
      * {
          font: "JetBrains Mono Nerd Font 10";
      }
    '';
    xsession.windowManager.i3.config.menu = "rofi -show drun -theme ~/.config/rofi/launchers/type-${toString cfg.type}/style-${toString cfg.style}.rasi";

    programs.rofi = {
      enable = true;
      package = pkgs.rofi.override {
        plugins = with pkgs; [
          rofi-emoji
          rofi-calc
          rofi-systemd
          rofi-menugen
          rofi-bluetooth
          rofi-power-menu
          rofi-pulse-select
          rofi-file-browser
          rofi-mpd
          rofi-pass
        ];
      };
      configPath = "$XDG_CONFIG_HOME/rofi/rofi-config.rasi";
    };

    xdg.configFile = {
      "rofi/rofi-config.rasi".source = lib.mkForce ./files/config.rasi;
      "rofi/applets/bin/appasroot.sh".source = ./files/applets/bin/appasroot.sh;
      "rofi/applets/bin/appasroot.sh".executable = true;
      "rofi/applets/bin/apps.sh".source = ./files/applets/bin/apps.sh;
      "rofi/applets/bin/apps.sh".executable = true;
      "rofi/applets/bin/battery.sh".source = ./files/applets/bin/battery.sh;
      "rofi/applets/bin/battery.sh".executable = true;
      "rofi/applets/bin/brightness.sh".source = ./files/applets/bin/brightness.sh;
      "rofi/applets/bin/brightness.sh".executable = true;
      "rofi/applets/bin/mpd.sh".source = ./files/applets/bin/mpd.sh;
      "rofi/applets/bin/mpd.sh".executable = true;
      "rofi/applets/bin/powermenu.sh".source = ./files/applets/bin/powermenu.sh;
      "rofi/applets/bin/powermenu.sh".executable = true;
      "rofi/applets/bin/quicklinks.sh".source = ./files/applets/bin/quicklinks.sh;
      "rofi/applets/bin/quicklinks.sh".executable = true;
      "rofi/applets/bin/screenshot.sh".source = ./files/applets/bin/screenshot.sh;
      "rofi/applets/bin/screenshot.sh".executable = true;
      "rofi/applets/bin/volume.sh".source = ./files/applets/bin/volume.sh;
      "rofi/applets/bin/volume.sh".executable = true;
      "rofi/applets/type-1/style-1.rasi".source = ./files/applets/type-1/style-1.rasi;
      "rofi/applets/type-1/style-2.rasi".source = ./files/applets/type-1/style-2.rasi;
      "rofi/applets/type-1/style-3.rasi".source = ./files/applets/type-1/style-3.rasi;
      "rofi/applets/type-2/style-1.rasi".source = ./files/applets/type-2/style-1.rasi;
      "rofi/applets/type-2/style-2.rasi".source = ./files/applets/type-2/style-2.rasi;
      "rofi/applets/type-2/style-3.rasi".source = ./files/applets/type-2/style-3.rasi;
      "rofi/applets/type-3/style-1.rasi".source = ./files/applets/type-3/style-1.rasi;
      "rofi/applets/type-3/style-2.rasi".source = ./files/applets/type-3/style-2.rasi;
      "rofi/applets/type-3/style-3.rasi".source = ./files/applets/type-3/style-3.rasi;
      "rofi/applets/type-4/style-1.rasi".source = ./files/applets/type-4/style-1.rasi;
      "rofi/applets/type-4/style-2.rasi".source = ./files/applets/type-4/style-2.rasi;
      "rofi/applets/type-4/style-3.rasi".source = ./files/applets/type-4/style-3.rasi;
      "rofi/applets/type-5/style-1.rasi".source = ./files/applets/type-5/style-1.rasi;
      "rofi/applets/type-5/style-2.rasi".source = ./files/applets/type-5/style-2.rasi;
      "rofi/applets/type-5/style-3.rasi".source = ./files/applets/type-5/style-3.rasi;
      "rofi/colors/adapta.rasi".source = ./files/colors/adapta.rasi;
      "rofi/colors/arc.rasi".source = ./files/colors/arc.rasi;
      "rofi/colors/black.rasi".source = ./files/colors/black.rasi;
      "rofi/colors/catppuccin.rasi".source = ./files/colors/catppuccin.rasi;
      "rofi/colors/cyberpunk.rasi".source = ./files/colors/cyberpunk.rasi;
      "rofi/colors/dracula.rasi".source = ./files/colors/dracula.rasi;
      "rofi/colors/everforest.rasi".source = ./files/colors/everforest.rasi;
      "rofi/colors/gruvbox.rasi".source = ./files/colors/gruvbox.rasi;
      "rofi/colors/lovelace.rasi".source = ./files/colors/lovelace.rasi;
      "rofi/colors/navy.rasi".source = ./files/colors/navy.rasi;
      "rofi/colors/nord.rasi".source = ./files/colors/nord.rasi;
      "rofi/colors/onedark.rasi".source = ./files/colors/onedark.rasi;
      "rofi/colors/paper.rasi".source = ./files/colors/paper.rasi;
      "rofi/colors/solarized.rasi".source = ./files/colors/solarized.rasi;
      "rofi/colors/tokyonight.rasi".source = ./files/colors/tokyonight.rasi;
      "rofi/colors/yousai.rasi".source = ./files/colors/yousai.rasi;
      "rofi/images/a.png".source = ./files/images/a.png;
      "rofi/images/b.png".source = ./files/images/b.png;
      "rofi/images/c.png".source = ./files/images/c.png;
      "rofi/images/d.png".source = ./files/images/d.png;
      "rofi/images/e.jpg".source = ./files/images/e.jpg;
      "rofi/images/f.png".source = ./files/images/f.png;
      "rofi/images/g.png".source = ./files/images/g.png;
      "rofi/images/h.jpg".source = ./files/images/h.jpg;
      "rofi/images/i.jpg".source = ./files/images/i.jpg;
      "rofi/images/j.jpg".source = ./files/images/j.jpg;
      "rofi/images/paper.png".source = ./files/images/paper.png;
      "rofi/images/user.jpeg".source = ./files/images/user.jpeg;
      "rofi/images/flowers-1.png".source = ./files/images/flowers-1.png;
      "rofi/images/flowers-2.png".source = ./files/images/flowers-2.png;
      "rofi/images/flowers-3.png".source = ./files/images/flowers-3.png;
      "rofi/launchers/type-1/style-1.rasi".source = ./files/launchers/type-1/style-1.rasi;
      "rofi/launchers/type-1/style-2.rasi".source = ./files/launchers/type-1/style-2.rasi;
      "rofi/launchers/type-1/style-3.rasi".source = ./files/launchers/type-1/style-3.rasi;
      "rofi/launchers/type-1/style-4.rasi".source = ./files/launchers/type-1/style-4.rasi;
      "rofi/launchers/type-1/style-5.rasi".source = ./files/launchers/type-1/style-5.rasi;
      "rofi/launchers/type-1/style-6.rasi".source = ./files/launchers/type-1/style-6.rasi;
      "rofi/launchers/type-1/style-7.rasi".source = ./files/launchers/type-1/style-7.rasi;
      "rofi/launchers/type-1/style-8.rasi".source = ./files/launchers/type-1/style-8.rasi;
      "rofi/launchers/type-1/style-9.rasi".source = ./files/launchers/type-1/style-9.rasi;
      "rofi/launchers/type-1/style-10.rasi".source = ./files/launchers/type-1/style-10.rasi;
      "rofi/launchers/type-1/style-11.rasi".source = ./files/launchers/type-1/style-11.rasi;
      "rofi/launchers/type-1/style-12.rasi".source = ./files/launchers/type-1/style-12.rasi;
      "rofi/launchers/type-1/style-13.rasi".source = ./files/launchers/type-1/style-13.rasi;
      "rofi/launchers/type-1/style-14.rasi".source = ./files/launchers/type-1/style-14.rasi;
      "rofi/launchers/type-1/style-15.rasi".source = ./files/launchers/type-1/style-15.rasi;
      "rofi/launchers/type-1/launcher.sh".source = ./files/launchers/type-1/launcher.sh;
      "rofi/launchers/type-1/launcher.sh".executable = true;
      "rofi/launchers/type-1/shared/colors.rasi".source = ./files/launchers/type-1/shared/colors.rasi;
      "rofi/launchers/type-1/shared/fonts.rasi".source = ./files/launchers/type-1/shared/fonts.rasi;
      "rofi/launchers/type-2/style-1.rasi".source = ./files/launchers/type-2/style-1.rasi;
      "rofi/launchers/type-2/style-2.rasi".source = ./files/launchers/type-2/style-2.rasi;
      "rofi/launchers/type-2/style-3.rasi".source = ./files/launchers/type-2/style-3.rasi;
      "rofi/launchers/type-2/style-4.rasi".source = ./files/launchers/type-2/style-4.rasi;
      "rofi/launchers/type-2/style-5.rasi".source = ./files/launchers/type-2/style-5.rasi;
      "rofi/launchers/type-2/style-6.rasi".source = ./files/launchers/type-2/style-6.rasi;
      "rofi/launchers/type-2/style-7.rasi".source = ./files/launchers/type-2/style-7.rasi;
      "rofi/launchers/type-2/style-8.rasi".source = ./files/launchers/type-2/style-8.rasi;
      "rofi/launchers/type-2/style-9.rasi".source = ./files/launchers/type-2/style-9.rasi;
      "rofi/launchers/type-2/style-10.rasi".source = ./files/launchers/type-2/style-10.rasi;
      "rofi/launchers/type-2/style-11.rasi".source = ./files/launchers/type-2/style-11.rasi;
      "rofi/launchers/type-2/style-12.rasi".source = ./files/launchers/type-2/style-12.rasi;
      "rofi/launchers/type-2/style-13.rasi".source = ./files/launchers/type-2/style-13.rasi;
      "rofi/launchers/type-2/style-14.rasi".source = ./files/launchers/type-2/style-14.rasi;
      "rofi/launchers/type-2/style-15.rasi".source = ./files/launchers/type-2/style-15.rasi;
      "rofi/launchers/type-2/launcher.sh".source = ./files/launchers/type-2/launcher.sh;
      "rofi/launchers/type-2/launcher.sh".executable = true;
      "rofi/launchers/type-2/shared/colors.rasi".source = ./files/launchers/type-2/shared/colors.rasi;
      "rofi/launchers/type-2/shared/fonts.rasi".source = ./files/launchers/type-2/shared/fonts.rasi;
      "rofi/launchers/type-3/style-1.rasi".source = ./files/launchers/type-3/style-1.rasi;
      "rofi/launchers/type-3/style-2.rasi".source = ./files/launchers/type-3/style-2.rasi;
      "rofi/launchers/type-3/style-3.rasi".source = ./files/launchers/type-3/style-3.rasi;
      "rofi/launchers/type-3/style-4.rasi".source = ./files/launchers/type-3/style-4.rasi;
      "rofi/launchers/type-3/style-5.rasi".source = ./files/launchers/type-3/style-5.rasi;
      "rofi/launchers/type-3/style-6.rasi".source = ./files/launchers/type-3/style-6.rasi;
      "rofi/launchers/type-3/style-7.rasi".source = ./files/launchers/type-3/style-7.rasi;
      "rofi/launchers/type-3/style-8.rasi".source = ./files/launchers/type-3/style-8.rasi;
      "rofi/launchers/type-3/style-9.rasi".source = ./files/launchers/type-3/style-9.rasi;
      "rofi/launchers/type-3/style-10.rasi".source = ./files/launchers/type-3/style-10.rasi;
      "rofi/launchers/type-3/launcher.sh".source = ./files/launchers/type-3/launcher.sh;
      "rofi/launchers/type-3/launcher.sh".executable = true;
      "rofi/launchers/type-3/shared/colors.rasi".source = ./files/launchers/type-3/shared/colors.rasi;
      "rofi/launchers/type-3/shared/fonts.rasi".source = ./files/launchers/type-3/shared/fonts.rasi;
      "rofi/launchers/type-4/style-1.rasi".source = ./files/launchers/type-4/style-1.rasi;
      "rofi/launchers/type-4/style-2.rasi".source = ./files/launchers/type-4/style-2.rasi;
      "rofi/launchers/type-4/style-3.rasi".source = ./files/launchers/type-4/style-3.rasi;
      "rofi/launchers/type-4/style-4.rasi".source = ./files/launchers/type-4/style-4.rasi;
      "rofi/launchers/type-4/style-5.rasi".source = ./files/launchers/type-4/style-5.rasi;
      "rofi/launchers/type-4/style-6.rasi".source = ./files/launchers/type-4/style-6.rasi;
      "rofi/launchers/type-4/style-7.rasi".source = ./files/launchers/type-4/style-7.rasi;
      "rofi/launchers/type-4/style-8.rasi".source = ./files/launchers/type-4/style-8.rasi;
      "rofi/launchers/type-4/style-9.rasi".source = ./files/launchers/type-4/style-9.rasi;
      "rofi/launchers/type-4/style-10.rasi".source = ./files/launchers/type-4/style-10.rasi;
      "rofi/launchers/type-4/launcher.sh".source = ./files/launchers/type-4/launcher.sh;
      "rofi/launchers/type-4/launcher.sh".executable = true;
      "rofi/launchers/type-4/shared/colors.rasi".source = ./files/launchers/type-4/shared/colors.rasi;
      "rofi/launchers/type-4/shared/fonts.rasi".source = ./files/launchers/type-4/shared/fonts.rasi;
      "rofi/launchers/type-5/style-1.rasi".source = ./files/launchers/type-5/style-1.rasi;
      "rofi/launchers/type-5/style-2.rasi".source = ./files/launchers/type-5/style-2.rasi;
      "rofi/launchers/type-5/style-3.rasi".source = ./files/launchers/type-5/style-3.rasi;
      "rofi/launchers/type-5/style-4.rasi".source = ./files/launchers/type-5/style-4.rasi;
      "rofi/launchers/type-5/style-5.rasi".source = ./files/launchers/type-5/style-5.rasi;
      "rofi/launchers/type-5/launcher.sh".source = ./files/launchers/type-5/launcher.sh;
      "rofi/launchers/type-5/launcher.sh".executable = true;
      "rofi/launchers/type-6/style-1.rasi".source = ./files/launchers/type-6/style-1.rasi;
      "rofi/launchers/type-6/style-2.rasi".source = ./files/launchers/type-6/style-2.rasi;
      "rofi/launchers/type-6/style-3.rasi".source = ./files/launchers/type-6/style-3.rasi;
      "rofi/launchers/type-6/style-4.rasi".source = ./files/launchers/type-6/style-4.rasi;
      "rofi/launchers/type-6/style-5.rasi".source = ./files/launchers/type-6/style-5.rasi;
      "rofi/launchers/type-6/style-6.rasi".source = ./files/launchers/type-6/style-6.rasi;
      "rofi/launchers/type-6/style-7.rasi".source = ./files/launchers/type-6/style-7.rasi;
      "rofi/launchers/type-6/style-8.rasi".source = ./files/launchers/type-6/style-8.rasi;
      "rofi/launchers/type-6/style-9.rasi".source = ./files/launchers/type-6/style-9.rasi;
      "rofi/launchers/type-6/style-10.rasi".source = ./files/launchers/type-6/style-10.rasi;
      "rofi/launchers/type-6/launcher.sh".source = ./files/launchers/type-6/launcher.sh;
      "rofi/launchers/type-6/launcher.sh".executable = true;
      "rofi/launchers/type-7/style-1.rasi".source = ./files/launchers/type-7/style-1.rasi;
      "rofi/launchers/type-7/style-2.rasi".source = ./files/launchers/type-7/style-2.rasi;
      "rofi/launchers/type-7/style-3.rasi".source = ./files/launchers/type-7/style-3.rasi;
      "rofi/launchers/type-7/style-4.rasi".source = ./files/launchers/type-7/style-4.rasi;
      "rofi/launchers/type-7/style-5.rasi".source = ./files/launchers/type-7/style-5.rasi;
      "rofi/launchers/type-7/style-6.rasi".source = ./files/launchers/type-7/style-6.rasi;
      "rofi/launchers/type-7/style-7.rasi".source = ./files/launchers/type-7/style-7.rasi;
      "rofi/launchers/type-7/style-8.rasi".source = ./files/launchers/type-7/style-8.rasi;
      "rofi/launchers/type-7/style-9.rasi".source = ./files/launchers/type-7/style-9.rasi;
      "rofi/launchers/type-7/style-10.rasi".source = ./files/launchers/type-7/style-10.rasi;
      "rofi/launchers/type-7/launcher.sh".source = ./files/launchers/type-7/launcher.sh;
      "rofi/launchers/type-7/launcher.sh".executable = true;
      "rofi/powermenu/type-1/style-1.rasi".source = ./files/powermenu/type-1/style-1.rasi;
      "rofi/powermenu/type-1/style-2.rasi".source = ./files/powermenu/type-1/style-2.rasi;
      "rofi/powermenu/type-1/style-3.rasi".source = ./files/powermenu/type-1/style-3.rasi;
      "rofi/powermenu/type-1/style-4.rasi".source = ./files/powermenu/type-1/style-4.rasi;
      "rofi/powermenu/type-1/style-5.rasi".source = ./files/powermenu/type-1/style-5.rasi;
      "rofi/powermenu/type-1/powermenu.sh".source = ./files/powermenu/type-1/powermenu.sh;
      "rofi/powermenu/type-1/powermenu.sh".executable = true;
      "rofi/powermenu/type-1/shared/colors.rasi".source = ./files/powermenu/type-1/shared/colors.rasi;
      "rofi/powermenu/type-1/shared/fonts.rasi".source = ./files/powermenu/type-1/shared/fonts.rasi;
      "rofi/powermenu/type-2/style-1.rasi".source = ./files/powermenu/type-2/style-1.rasi;
      "rofi/powermenu/type-2/style-2.rasi".source = ./files/powermenu/type-2/style-2.rasi;
      "rofi/powermenu/type-2/style-3.rasi".source = ./files/powermenu/type-2/style-3.rasi;
      "rofi/powermenu/type-2/style-4.rasi".source = ./files/powermenu/type-2/style-4.rasi;
      "rofi/powermenu/type-2/style-5.rasi".source = ./files/powermenu/type-2/style-5.rasi;
      "rofi/powermenu/type-2/style-6.rasi".source = ./files/powermenu/type-2/style-6.rasi;
      "rofi/powermenu/type-2/style-7.rasi".source = ./files/powermenu/type-2/style-7.rasi;
      "rofi/powermenu/type-2/style-8.rasi".source = ./files/powermenu/type-2/style-8.rasi;
      "rofi/powermenu/type-2/style-9.rasi".source = ./files/powermenu/type-2/style-9.rasi;
      "rofi/powermenu/type-2/style-10.rasi".source = ./files/powermenu/type-2/style-10.rasi;
      "rofi/powermenu/type-2/powermenu.sh".source = ./files/powermenu/type-2/powermenu.sh;
      "rofi/powermenu/type-2/powermenu.sh".executable = true;
      "rofi/powermenu/type-2/shared/colors.rasi".source = ./files/powermenu/type-2/shared/colors.rasi;
      "rofi/powermenu/type-2/shared/fonts.rasi".source = ./files/powermenu/type-2/shared/fonts.rasi;
      "rofi/powermenu/type-3/style-1.rasi".source = ./files/powermenu/type-3/style-1.rasi;
      "rofi/powermenu/type-3/style-2.rasi".source = ./files/powermenu/type-3/style-2.rasi;
      "rofi/powermenu/type-3/style-3.rasi".source = ./files/powermenu/type-3/style-3.rasi;
      "rofi/powermenu/type-3/style-4.rasi".source = ./files/powermenu/type-3/style-4.rasi;
      "rofi/powermenu/type-3/style-5.rasi".source = ./files/powermenu/type-3/style-5.rasi;
      "rofi/powermenu/type-3/powermenu.sh".source = ./files/powermenu/type-3/powermenu.sh;
      "rofi/powermenu/type-3/powermenu.sh".executable = true;
      "rofi/powermenu/type-3/shared/colors.rasi".source = ./files/powermenu/type-3/shared/colors.rasi;
      "rofi/powermenu/type-3/shared/fonts.rasi".source = ./files/powermenu/type-3/shared/fonts.rasi;
      "rofi/powermenu/type-4/style-1.rasi".source = ./files/powermenu/type-4/style-1.rasi;
      "rofi/powermenu/type-4/style-2.rasi".source = ./files/powermenu/type-4/style-2.rasi;
      "rofi/powermenu/type-4/style-3.rasi".source = ./files/powermenu/type-4/style-3.rasi;
      "rofi/powermenu/type-4/style-4.rasi".source = ./files/powermenu/type-4/style-4.rasi;
      "rofi/powermenu/type-4/style-5.rasi".source = ./files/powermenu/type-4/style-5.rasi;
      "rofi/powermenu/type-4/powermenu.sh".source = ./files/powermenu/type-4/powermenu.sh;
      "rofi/powermenu/type-4/powermenu.sh".executable = true;
      "rofi/powermenu/type-4/shared/colors.rasi".source = ./files/powermenu/type-4/shared/colors.rasi;
      "rofi/powermenu/type-4/shared/fonts.rasi".source = ./files/powermenu/type-4/shared/fonts.rasi;
      "rofi/powermenu/type-5/style-1.rasi".source = ./files/powermenu/type-5/style-1.rasi;
      "rofi/powermenu/type-5/style-2.rasi".source = ./files/powermenu/type-5/style-2.rasi;
      "rofi/powermenu/type-5/style-3.rasi".source = ./files/powermenu/type-5/style-3.rasi;
      "rofi/powermenu/type-5/style-4.rasi".source = ./files/powermenu/type-5/style-4.rasi;
      "rofi/powermenu/type-5/style-5.rasi".source = ./files/powermenu/type-5/style-5.rasi;
      "rofi/powermenu/type-5/powermenu.sh".source = ./files/powermenu/type-5/powermenu.sh;
      "rofi/powermenu/type-5/powermenu.sh".executable = true;
      "rofi/powermenu/type-6/style-1.rasi".source = ./files/powermenu/type-6/style-1.rasi;
      "rofi/powermenu/type-6/style-2.rasi".source = ./files/powermenu/type-6/style-2.rasi;
      "rofi/powermenu/type-6/style-3.rasi".source = ./files/powermenu/type-6/style-3.rasi;
      "rofi/powermenu/type-6/style-4.rasi".source = ./files/powermenu/type-6/style-4.rasi;
      "rofi/powermenu/type-6/style-5.rasi".source = ./files/powermenu/type-6/style-5.rasi;
      "rofi/powermenu/type-6/powermenu.sh".source = ./files/powermenu/type-6/powermenu.sh;
      "rofi/powermenu/type-6/powermenu.sh".executable = true;
      "rofi/scripts/launcher_t1".source = ./files/scripts/launcher_t1;
      "rofi/scripts/launcher_t2".source = ./files/scripts/launcher_t2;
      "rofi/scripts/launcher_t3".source = ./files/scripts/launcher_t3;
      "rofi/scripts/launcher_t4".source = ./files/scripts/launcher_t4;
      "rofi/scripts/launcher_t5".source = ./files/scripts/launcher_t5;
      "rofi/scripts/launcher_t6".source = ./files/scripts/launcher_t6;
      "rofi/scripts/launcher_t7".source = ./files/scripts/launcher_t7;
      "rofi/scripts/powermenu_t1".source = ./files/scripts/powermenu_t1;
      "rofi/scripts/powermenu_t2".source = ./files/scripts/powermenu_t2;
      "rofi/scripts/powermenu_t3".source = ./files/scripts/powermenu_t3;
      "rofi/scripts/powermenu_t4".source = ./files/scripts/powermenu_t4;
      "rofi/scripts/powermenu_t5".source = ./files/scripts/powermenu_t5;
      "rofi/scripts/powermenu_t6".source = ./files/scripts/powermenu_t6;
    };
  };
}
