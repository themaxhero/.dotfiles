{ mkMerge, nix-doom-emacs, ... }:
{
  imports = [
    nix-doom-emacs.hmModule
    ./base
    ./development
    ./gaming
    ./graphical-interface
  ];
}