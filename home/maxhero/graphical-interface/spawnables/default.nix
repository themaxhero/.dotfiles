{ config, pkgs, ... }:
let
  launch-eww = pkgs.writeShellScriptBin "launch-eww" ''
    ${pkgs.killall}/bin/killall ${pkgs.eww-wayland}/bin/eww
    ${pkgs.eww-wayland}/bin/eww daemon && ${pkgs.eww-wayland}/bin/eww open bar-left && ${pkgs.eww-wayland}/bin/eww open bar-right
  '';
in
{
  wayland = {
    menu = "${config.programs.rofi.package}/bin/rofi -show drun -theme ~/.config/rofi/launchers/type-${toString config.rofiConfig.type}/style-${toString config.rofiConfig.type}.rasi";
    notification-daemon = "${pkgs.swaynotificationcenter}/bin/swaync-client";
    terminal = "${pkgs.kitty}/bin/kitty";
    bar = "${launch-eww}/bin/launch-eww";
    screenshot = "${pkgs.grimblast}/bin/grimblast copy area";
    browser = "firefox.desktop";
    ime = "${config.i18n.inputMethod.package}/bin/fcitx5";
    lock = "~/.config/sway/lock.sh --indicator --indicator-radius 100 --ring-color e40000 --clock";
    network-applet = "${pkgs.networkmanagerapplet}/bin/nm-applet";
  };
  xorg = {
    menu = "${config.programs.rofi.package}/bin/rofi -show drun -theme ~/.config/rofi/launchers/type-${toString config.rofiConfig.type}/style-${toString config.rofiConfig.type}.rasi";
    notification-daemon = "${pkgs.dunst}/bin/dunst";
    terminal = "${pkgs.kitty}/bin/kitty";
    bar = "${launch-eww}/bin/launch-eww";
    screenshot = "${pkgs.flameshot}/bin/flameshot gui";
    browser = "firefox.desktop";
    ime = "${config.i18n.inputMethod.package}/bin/fcitx5";
    wallpaper = "${pkgs.feh}/bin/feh --bg-fill ~/.wallpaper.jpg";
    lock = "";
    network-applet = "${pkgs.networkmanagerapplet}/bin/nm-applet";
  };
}
