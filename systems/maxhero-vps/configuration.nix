# The top lambda and it super set of parameters.
{ config, lib, pkgs, ... }:

# NixOS-defined options
{
  # OCI-related config
  oci.efi = true;

  # Network.
  networking = {
    hostId = "be2568e2";
    hostName = "maxhero-vps";
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8"
      "8.8.4.4"
    ];
  };

  # Let's Encrypt
  security.acme = {
    acceptTerms = true;
    defaults.email = "contact@maxhero.dev";
    certs."vps.maxhero.com.br".extraDomainNames = [ "dns.maxhero.com.br" ];
  };

  # Changing the congestion algorithm to bbr in order to reduce packet loss at low throughput
  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };

  services._3proxy = {
    enable = true;
    services = [
      {
        type = "socks";
          auth = [ "strong" ];
          acl = [ {
            rule = "allow";
            users = [ "maxhero" ];
          }
        ];
      }
    ];
    usersFile = "/etc/3proxy.passwd";
  };

  development = {
    enable = false;
    languages = [];
  };
  graphical-interface.enable = false;
  gaming.enable = false;

  environment.etc = {
    "3proxy.passwd".text = ''
      maxhero:CR:$1$XQ/ceZ6w$Cetl9.PIz53JQ0RZcJnYF.
    '';
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
  #home-manager.users.maxhero.home.stateVersion = "21.11";
}