{ lib, pkgs, ...}:
{
  programs.doom-emacs = lib.mkIf seat ({
    enable = true;
    doomPrivateDir = ./doom.d;
    emacsPackagesOverlay = self: super: {
     magit-delta = super.magit-delta.overrideAttrs (esuper: {
       buildInputs = esuper.buildInputs ++ [ pkgs.git ];
     });
    };
  });
}