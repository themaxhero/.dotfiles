{ self, ... }@attrs: {
  system = "x86_64-linux";
  specialArgs = attrs;
  modules = [
    self.outputs.nixosModules.hero
    ./configuration.nix
    ./hardware-configuration.nix
  ];
}
