{ self, nixpkgs, flake-utils, devshell, ... }@attrs:
(flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs {
      inherit system;
      overlays = [ devshell.overlay ];
    };
  in
  {
    devShells =
      nixpkgs.lib.trivial.pipe (self + /shells) [
        (dir: builtins.readDir dir)
        (pairs: nixpkgs.lib.attrsets.filterAttrs (key: value: value == "directory") pairs)
        (dirs: builtins.mapAttrs (shell: _: import (self + "/shells/${shell}") { inherit pkgs; }) dirs)
      ];
  }
)).devShells
