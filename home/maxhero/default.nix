{ self, nixpkgs, nix-doom-emacs, ... }@attrs:
let
  lib = nixpkgs.lib;
in
{
  mkHome = { ... }@opts:
    {
      imports =
        [ (self + /home/maxhero/base) ]
        ++ (lib.optionals opts.enableDoomEmacs [ nix-doom-emacs.hmModule ])
        ++ (lib.optionals opts.enableDevelopment [
          (self + /home/maxhero/development)
          (self + /home/maxhero/shells/zsh.nix)
        ])
        ++ (lib.optionals opts.personal [
          (self + /home/maxhero/personal)
        ])
        ++ (lib.optionals opts.enableGaming [ (self + /home/maxhero/gaming) ])
        ++ (lib.optionals opts.enableUI [
          (self + /home/maxhero/graphical-interface/rofi)
          (self + /home/maxhero/graphical-interface/eww)
          (self + /home/maxhero/graphical-interface/dconf)
          (self + /home/maxhero/graphical-interface/i3)
          (self + /home/maxhero/graphical-interface)
        ]);
    };
}
