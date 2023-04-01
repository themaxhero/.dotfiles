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
    programs.eww = {
      enable = true;
      configDir = ../eww;
    };
  };
}
