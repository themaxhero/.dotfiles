/*
  This file is just a home-manager module to make easier to use this github repo:
  Using: polybar-replacement from https://github.com/druskus20/eugh/tree/master/polybar-replacement
*/
{ self, config, lib, pkgs, ... }:
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
      configDir = self + /home/maxhero/graphical-interface/eww;
    };
  };
}
