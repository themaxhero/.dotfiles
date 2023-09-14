# This file is not being used anymore
# It will be here in case I want to migrate to wirenix again.
{...}:
let
  personalPrefixV4 = "10.100.0";
  personalPrefixV6 = "fdb7:2e96:8e57:";
  wPrefixV4 = "10.101.0";
  wPrefixV6 = "ffff:2e96:8e57:";
in
{
  version = "v1";
  subnets = [
    {
      name = "personal";
      endpoints = [
        { port = 51820; }
      ];
    }
    {
      name = "w";
      endpoints = [
        { port = 58888; }
      ];
    }
  ];
  peers = [
    {
      privateKeyFile = "/home/maxhero/wireguard-keys/private";
      subnets = {
        personal = {
          listenPort = 51820;
          name = "vps";
          ipAddresses = [ "${personalPrefixV4}.1/24" "${personalPrefixV6}:1/64" ];
        };
        w = {
          listenPort = 58888;
          name = "vps";
          ipAddresses = [ "${wPrefixV4}.1/24" "${wPrefixV6}:1/64" ];
        };
      };
    }
    {
      publicKey = "3guu9BcaID9IvvpznNNe1ZxoFsm2rH8m+O7XqbC7WVU=";
      endpoints = [ { ip = "gungnir-linux"; } ];
      subnets = {
        personal = {
          listenPort = 51820;
          name = "gungnir-linux";
          ipAddresses = [
              "${personalPrefixV4}.2/32"
              "${personalPrefixV6}:2/128"
              # Multicast
              "224.0.0.251/32"
              "ff02::fb/128"
          ];
        };
      };
    }
    {
      publicKey = "l4LYC2w9yD+r51qDiGaUG6Y8XNpsdUEp1h1yRzgJJ00=";
      endpoints = [ { ip = "gungnir-windows"; } ];
      subnets = {
        personal = {
          listenPort = 51820;
          name = "gungnir-windows";
          ipAddresses = [
            "${personalPrefixV4}.3/32"
            "${personalPrefixV6}:3/128"
            # Multicast
            "224.0.0.251/32"
            "ff02::fb/128"
          ];
        };
      };
    }
    {
      publicKey = "N0gfeLuS0AuIEl58Xl80wwGY9Tvn+QyhCnymj64mX04=";
      endpoints = [{ ip = "uchigatana-linux"; } ];
      subnets = {
        personal = {
          listenPort = 51820;
          name = "uchigatana-linux";
          ipAddresses = [
            "${personalPrefixV4}.4/32"
            "${personalPrefixV6}:4/128"
            # Multicast
            "224.0.0.251/32"
            "ff02::fb/128"
          ];
        };
      };
    }
    {
      publicKey = "NXSw6UHX600HCau1zyfzA3aDB7TYNnRUdnp37JGcWE4=";
      endpoints = [ { ip = "uchigatana-windows"; } ];
      subnets = {
        personal = {
          listenPort = 51820;
          name = "uchigatana-windows";
          ipAddresses = [
            "${personalPrefixV4}.5/32"
            "${personalPrefixV6}:5/128"
            # Multicast
            "224.0.0.251/32"
            "ff02::fb/128"
          ];
        };
      };
    }
    {
      publicKey = "GE+KyrEaZNRuT9SaQFlKU8gnBMEmFu9XX2O8mdca11U=";
      endpoints = [ { ip = "poco-x3-pro"; } ];
      subnets = {
        personal = {
          listenPort = 51820;
          name = "poco-x3-pro";
          ipAddresses = [
            "${personalPrefixV4}.6/32"
            "${personalPrefixV6}:6/128"
            # Multicast
            "224.0.0.251/32"
            "ff02::fb/128"
          ];
        };
      };
    }
    {
      publicKey = "";
      endpoints = [ { ip = ""; } ];
      subnets = {
        w = {
          listenPort = 51820;
          name = "w-laptop";
          ipAddresses = [
            "${wPrefixV4}.1/24"
            "${wPrefixV6}:1/128"
          ];
        };
      };
    }
  ];
  groups = [];
  connections = [
    {
      a = [{
        type = "subnet";
        rule = "is";
        value = "personal";
      }];
      b = [{
        type = "subnet";
        rule = "is";
        value = "personal";
      }];
    }
    {
      a = [{
        type = "subnet";
        rule = "is";
        value = "w";
      }];
      b = [{
        type = "subnet";
        rule = "is";
        value = "w";
      }];
    }
  ];
}