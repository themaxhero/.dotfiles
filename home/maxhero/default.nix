{ mkMerge, nix-doom-emacs, ... }:
mkMerge [
  nix-doom-emacs.hmModule
  ./base
  ./development
  ./gaming
  ./graphical-interface
]
