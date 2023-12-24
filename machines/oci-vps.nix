{ self, config, lib, pkgs, ... }:
{
  deployment.targetHost = "vps.maxhero.com.br";
  # imports = [ (self + /systems/maxhero-vps) ];
}
