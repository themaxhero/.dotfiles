{ self, ... }:
pkgs:
{
  doomPrivateDir = self + /home/maxhero/development/emacs/doom.d;
  package = pkgs.emacsGcc;
  extraPackages = [
    pkgs.nodePackages.typescript
    pkgs.nodePackages.typescript-language-server
    pkgs.nodePackages.eslint
    pkgs.metals
    pkgs.haskellPackages.lsp
  ];
  emacsPackagesOverlay = self: super: {
    magit-delta = super.magit-delta.overrideAttrs
      (esuper: { buildInputs = esuper.buildInputs ++ [ pkgs.git ]; });
  };
}
