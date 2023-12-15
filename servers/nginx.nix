{ ... }:
{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts = {
      "vps.maxhero.com.br" = {
        forceSSL = true;
        enableACME = true;
      };
      "dns.maxhero.com.br" = {
        forceSSL = true;
        useACMEHost = "vps.maxhero.com.br";
        locations."/dns-query" = {
          proxyPass = "https://127.0.0.1:3334/dns-query";
        };
      };
    };
    appendHttpConfig = ''
      aio threads;
    '';
  };
}
