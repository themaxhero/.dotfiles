{ nixpkgs, flake-utils, devshell, ...}@attrs:
(flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs {
        inherit system;
        overlays = [ devshell.overlay ];
    };
  in
  {
    devShells =
      nixpkgs.lib.trivial.pipe ./. [
        (dir: builtins.readDir dir)
        (pairs: nixpkgs.lib.attrsets.filterAttrs (key: value: value == "directory") pairs)
        (dirs: builtins.mapAttrs (shell: _: import (./. + "/${shell}") { inherit pkgs; }) dirs)
      ];
  }
)).devShells
