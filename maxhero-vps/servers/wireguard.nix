{ pkgs, ... }:
let
  eth0 = "enp0s3";

  wgPrefixV4 = "10.100.0";
  wgPrefixV6 = "fda4:4413:3bb1:";
in
{
  networking = {
    nat = {
      enable = true;
      enableIPv6 = true;
      externalInterface = eth0;
      internalInterfaces = [ "wg0" ];
    };

    wireguard = {
      interfaces = {
        wg0 = {
          ips = [ "${wgPrefixV4}.1/24" "${wgPrefixV6}:1/64" ];
          listenPort = 51820;
          privateKeyFile = "/home/pedrohlc/Projects/com.pedrohlc/wireguard-keys/private";
          peers = [];
          postSetup = ''
                        ip link set wg0 multicast on
            	    ${pkgs.iptables}/bin/iptables -A FORWARD -i wg0 -j ACCEPT
            	    ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s ${wgPrefixV4}.0/24 -o ${eth0} -j MASQUERADE
            	    ${pkgs.iptables}/bin/ip6tables -A FORWARD -i wg0 -j ACCEPT
            	    ${pkgs.iptables}/bin/ip6tables -t nat -A POSTROUTING -s ${wgPrefixV6}:0/64 -o ${eth0} -j MASQUERADE
          '';
          postShutdown = ''
            ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
            ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s ${wgPrefixV4}.0/24 -o ${eth0} -j MASQUERADE
            ${pkgs.iptables}/bin/ip6tables -D FORWARD -i wg0 -j ACCEPT
            ${pkgs.iptables}/bin/ip6tables -t nat -D POSTROUTING -s ${wgPrefixV6}:0/24 -o ${eth0} -j MASQUERADE
          '';
        };
      };
    };
  };

  # ip forwarding (missing NAT sysctl)
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
  };
}