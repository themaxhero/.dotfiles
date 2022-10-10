{ pkgs, ... }:
let
  eth0 = "enp0s3";

  wgPrefixV4 = "10.100.0";
  wgPrefixV6 = "fdb7:2e96:8e57:";
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
          privateKeyFile = "/home/maxhero/wireguard-keys/private";
          peers = [
            # Desktop (Linux)
            {
              publicKey = "ciwz56c/HlbnNxlHkTdxjbD00HI2mZCM0DuZoM64GlU=";
              allowedIPs = [
                "${wgPrefixV4}.2/32"
                "${wgPrefixV6}:2/128"
                # Multicast
                "224.0.0.251/32"
                "ff02::fb/128"
              ];
            }
            # Desktop (Windows)
            {
              publicKey = "l4LYC2w9yD+r51qDiGaUG6Y8XNpsdUEp1h1yRzgJJ00=";
              allowedIPs = [
                "${wgPrefixV4}.3/32"
                "${wgPrefixV6}:3/128"
                # Multicast
                "224.0.0.251/32"
                "ff02::fb/128"
              ];
            }
            # Laptop (Linux)
            {
              publicKey = "N0gfeLuS0AuIEl58Xl80wwGY9Tvn+QyhCnymj64mX04=";
              allowedIPs = [
                "${wgPrefixV4}.4/32"
                "${wgPrefixV6}:4/128"
                # Multicast
                "224.0.0.251/32"
                "ff02::fb/128"
              ];
            }
            # Laptop (Windows)
            {
              publicKey = "NXSw6UHX600HCau1zyfzA3aDB7TYNnRUdnp37JGcWE4=";
              allowedIPs = [
                "${wgPrefixV4}.5/32"
                "${wgPrefixV6}:5/128"
                # Multicast
                "224.0.0.251/32"
                "ff02::fb/128"
              ];
            }
          ];
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
