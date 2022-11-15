{ config, lib, ... }:
{
  options = {
    vpn = {
      enable = lib.mkEnableOption "Enable VPN";
      ips = lib.mkOption {
        type = types.listof types.str;
        description = "IPs inside Wireguard Network";
        example = ["10.100.0.2/24" "fdb7:2e96:8e57::2/64"];
      };
      privateKeyFile = lib.mkOption {
        type = types.str;
        description = "Path to file with wireguard's private key";
      };
    };
  };
  config = lib.mkIf config.vpn.enable {
    networking = {
      wireguard.interfaces.wg0 =
        {
          ips = config.vpn.ips;
          privateKeyFile = "/home/maxhero/wireguard-keys/private";
          peers = [
            {
              publicKey = "VDNKMNA0vHnyXNpm7ElTBaYYwJ87frD5mr+5jyqJkjY=";
              allowedIPs = [
                "0.0.0.0/0"
                "::/0"
              ];
              endpoint = "vps.maxhero.com.br:51820";
              persistentKeepalive = 25;
            }
          ];
          # I have access to all the network through allowedIPs
          # But by default, I only want routes to the VPN clients and multicast
          allowedIPsAsRoutes = false;
          postSetup = ''
            ip link set wg0 multicast on
            ip route replace "10.100.0.0/24" dev wg0 table main
            ip route replace "fda4:4413:3bb1::/64" dev wg0 table main
          '';
          postShutdown = ''
            ip route del "10.100.0.0/24" dev wg0
            ip route del "fda4:4413:3bb1::/64" dev wg0
          '';
        };
    };
  };
}