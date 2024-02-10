{ config, pkgs, specialArgs, ... }:
let
  launch-eww = pkgs.writeShellScriptBin "launch-eww" ''
    ${pkgs.killall}/bin/killall ${pkgs.eww}/bin/eww
    ${pkgs.eww}/bin/eww daemon && ${pkgs.eww}/bin/eww open bar-left && ${pkgs.eww}/bin/eww open bar-right
  '';
in
{
  xorg = {
    menu = "${pkgs.rofi}/bin/rofi -show drun -theme ~/.config/rofi/launchers/type-1/style-6.rasi";
    notification-daemon = "${pkgs.dunst}/bin/dunst";
    terminal = "${pkgs.kitty}/bin/kitty";
    bar = "${launch-eww}/bin/launch-eww";
    screenshot = "${pkgs.flameshot}/bin/flameshot gui";
    browser = "firefox.desktop";
    #ime = "${pkgs.fcitx5}/bin/fcitx5";
    ime = "${pkgs.ibus}/bin/ibus-daemon -rxRd";
    wallpaper = "${pkgs.feh}/bin/feh --bg-fill ~/.wallpaper.png";
    lock = "${pkgs.i3lock-fancy-rapid}/bin/i3lock";
    network-applet = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator";
  };
}
