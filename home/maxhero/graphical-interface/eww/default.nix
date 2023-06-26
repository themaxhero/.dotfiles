/*
  This file is just a home-manager module to make easier to use this github repo:
  Using:
   - polybar-replacement from https://github.com/druskus20/eugh/tree/master/polybar-replacement
   - i3 module from https://github.com/natperron/dotfiles/tree/main/.config/eww

  TODO:
    Get Calendar like in https://github.com/natperron/dotfiles/tree/main/.config/eww
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
    home.packages = with pkgs; [
      gh
    ];
    programs.eww = {
      enable = true;
      package = self.inputs.nixpkgs-master.legacyPackages.x86_64-linux.eww;
      configDir = self + /home/maxhero/graphical-interface/eww;
    };
  };
}
