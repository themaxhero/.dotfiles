{ nixpkgs, ...}@attrs:
nixpkgs.lib.trivial.pipe ./. [
  (dir: builtins.readDir dir)
  (pairs: nixpkgs.lib.attrsets.filterAttrs (key: value: value == "directory") pairs)
  (dirs: builtins.mapAttrs (mod: _: import (./. + "/${mod}") attrs) dirs)
]
