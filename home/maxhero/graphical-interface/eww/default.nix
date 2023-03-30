/*
  This file is just a home-manager module to make easier to use this github repo:
  Using: https://github.com/owenrumney/eww-bar
*/
{ config, lib, pkgs, ... }:
let
  cfg = config.ewwConfig;
in
{
  options.ewwConfig = {
    enable = lib.mkEnableOption "Enable eww config";
  };
  config = lib.mkIf cfg.enable {
    programs.eww.enable = true;
    xsession.windowManager.i3.config.statusCommand = "${pkgs.eww}/bin/eww daemon";
    xdg.configFile = {
      "eww/src/weather/go.mod".source = ./src/weather/go.mod;
      "eww/src/weather/main.go".source = ./src/weather/main.go;
      "eww/src/notifications-listener/go.sum".source = ./src/notifications-listener/go.sum;
      "eww/src/notifications-listener/notification.go".source = ./src/notifications-listener/notification.go;
      "eww/src/notifications-listener/go.mod".source = ./src/notifications-listener/go.mod;
      "eww/src/notifications-listener/main.go".source = ./src/notifications-listener/main.go;
      "eww/src/workspaces/go.sum".source = ./src/workspaces/go.sum;
      "eww/src/workspaces/go.mod".source = ./src/workspaces/go.mod;
      "eww/src/workspaces/main.go".source = ./src/workspaces/main.go;
      "eww/src/github/go.sum".source = ./src/github/go.sumsrc/github/go.sum;
      "eww/src/github/go.mod".source = ./src/github/go.modsrc/github/go.mod;
      "eww/src/github/main.go".source = ./src/github/main.go;
      "eww/listeners.yuck".source = ./listeners.yuck;
      "eww/eww.scss".source = ./eww.scss;
      "eww/controls.yuck".source = ./controls.yuck;
      "eww/pollers.yuck".source = ./pollers.yuck;
      "eww/gruvbox.scss".source = ./gruvbox.scss;
      "eww/variables.yuck".source = ./variables.yuck;
      "eww/revealer.yuck".source = ./revealer.yuck;
      "eww/scripts/getram".source = ./scripts/getram;
      "eww/scripts/getram".executable = true;
      "eww/scripts/getvol".source = ./scripts/getvol;
      "eww/scripts/getvol".executable = true;
      "eww/eww.yuck".source = ./eww.yuck;
      "eww/metrics.yuck".source = ./metrics.yuck;
    };
  };
}
