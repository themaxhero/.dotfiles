{ ... }:
{
  virtualisation.oci-containers.containers.firefly = {
    image = "fireflyiii/core:latest";
    ports = ["8000:8080"];
    volumes = [
      "firefly_iii_upload:/var/www/html/storage/upload"
    ];
    environment = {
      # < /dev/urandom tr -dc '[a-zA-Z][:digit:]' | head -c32
      "APP_KEY" = "opfUryV5FBAD7]yT[7py73IsqmU3M[lN";
      "DB_HOST" = "host.docker.internal";
      "DB_PORT" = "5432";
      "DB_CONNECTION" = "postgres";
      "DB_DATABASE" = "firefly";
      "DB_USERNAME" = "firefly";
      "DB_PASSWORD" = "firefly";
    };
  };
}