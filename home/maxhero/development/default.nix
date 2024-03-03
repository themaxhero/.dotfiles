{ self, lib, pkgs, specialArgs, ... }@attrs:
with specialArgs;
let
  bin = "${pkgs.direnv}/bin/direnv";
  direnvAllow = (path: "$DRY_RUN_CMD sh -c 'if [ -f \"${path}/.envrc\" ]; then ${bin} allow \"${path}\"; fi;'");
  vscode-pkg = import (self + /home/maxhero/development/vscode) attrs;
in
{
  home.packages = with pkgs; [
    fd
    wget
    unzip
    tree-sitter
    ripgrep
    roboto
    scientifica
    powerline-fonts
    sshfs
    bottom
    eza
    bat
    graphviz
    vscode-pkg
    ngrok
    insomnia
  ];

  fonts.fontconfig.enable = true;
  home.sessionVariables.ELIXIR_ERL_OPTIONS = "+fnu";

  programs.neovim = { enable = true; } // ((import (self + /home/maxhero/development/nvim) attrs) pkgs);
  #programs.doom-emacs = { enable = true; } // (self.outputs.doomEmacsHomeManagerConfig pkgs);
  home.activation = {
    direnvAllow = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${direnvAllow "$HOME"}
    '';
  };
}
