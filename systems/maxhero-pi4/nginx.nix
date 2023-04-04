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
          "/jellyfin".proxyPass = "http://127.0.0.1:8096";
          "/helloworld".proxyPass = "http://127.0.0.1:8000";
        };
      };
    };
    appendHttpConfig = ''
      aio threads;
    '';
  };
  virtualisation.oci-containers.containers = {
    http-helloworld = {
      image = "strm/helloworld-http:latest";
      ports = ["8000:8000"];
    };
  };
  services.jellyfin = {
    enable = true;
    user = "maxhero";
  };
}
