{ self, mkMerge, nix-doom-emacs, ... }:
{
  imports = [
    nix-doom-emacs.hmModule
    (self + /home/maxhero/base)
    (self + /home/maxhero/development)
    (self + /home/maxhero/gaming)
    (self + /home/maxhero/graphical-interface/rofi)
    (self + /home/maxhero/graphical-interface/eww)
    (self + /home/maxhero/graphical-interface)
    (self + /home/maxhero/shells/zsh.nix)
  ];
}
