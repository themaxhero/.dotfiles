{ self, nixpkgs, nix-doom-emacs, ... }@attrs:
let
  lib = nixpkgs.lib;
  vscode-pkg = import (self + /home/maxhero/development/vscode);
in
{
  mkHome =
    { username ? "maxhero"
    , homeDirectory ? "/home/${username}"
    , enableDoomEmacs ? false
    , enableVSCode ? false
    , enableDevelopment ? false
    , personal ? false
    , enableGaming ? false
    , enableUI ? false
    , extraModules ? [ ]
    , extraPackages ? [ ]
    , extraVSCodeExtensions ? [ ]
    , ...
    }:
    {
      imports =
        [ (self + /home/maxhero/base) ]
        ++ (lib.optionals enableDoomEmacs [ nix-doom-emacs.hmModule ])
        ++ (lib.optionals enableDevelopment [
          (self + /home/maxhero/development)
          (self + /home/maxhero/shells/zsh.nix)
        ])
        ++ (lib.optionals personal [
          (self + /home/maxhero/personal)
        ])
        ++ (lib.optionals enableGaming [ (self + /home/maxhero/gaming) ])
        ++ (lib.optionals enableUI [
          (self + /home/maxhero/graphical-interface/rofi)
          (self + /home/maxhero/graphical-interface/eww)
          (self + /home/maxhero/graphical-interface/dconf)
          (self + /home/maxhero/graphical-interface/i3)
          (self + /home/maxhero/graphical-interface)
        ])
        ++ [
          ({ pkgs, ... }: {
            home.packages = extraPackages ++ (lib.optionals enableVSCode [
              (vscode-pkg {
                inherit pkgs;
                extraExtensions = extraVSCodeExtensions;
              })
            ]);
            home.username = username;
            home.homeDirectory = homeDirectory;
          })
        ]
        ++ extraModules;
    };
}
