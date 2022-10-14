{ flake-utils, devshell, ...}@attrs:
(flake-utils.lib.eachDefaultSystem (system:
    let
    pkgs = import nixpkgs {
        inherit system;
        overlays = [ devshell.overlay ];
    };
    in
    {
    devShells = {
        "maintain" = (import ./shells/maintain.nix attrs);
    };
    }
)).devShells;