{ ... }:
{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts = {
      "maxhero-pi4" = {
        forceSSL = false;
        locations = {
          "/".proxyPass = "https://127.0.0.1:8000";
        };
      };
    };
    appendHttpConfig = ''
      aio threads;
    '';
  };
  virtualisation.oci-containers.containers = {
    http-helloworld = {
      image = "strm/nginx-balancer:latest";
      ports = ["8000:80"];
    };
  };
}
