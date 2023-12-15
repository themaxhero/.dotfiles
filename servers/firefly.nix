{ ... }:
{
  virtualisation.oci-containers.containers.firefly = {
    image = "fireflyiii/core:latest";
    volumes = [
      "firefly_iii_upload:/var/www/html/storage/upload"
    ];
    extraOptions = [ "--network=host" ];
    environment = {
      # < /dev/urandom tr -dc '[a-zA-Z][:digit:]' | head -c32
      "APP_KEY" = "opfUryV5FBAD7]yT[7py73IsqmU3M[lN";
      "DB_HOST" = "localhost";
      "DB_PORT" = "5432";
      "DB_CONNECTION" = "pgsql";
      "DB_DATABASE" = "firefly";
      "DB_USERNAME" = "postgres";
      "DB_PASSWORD" = "postgres";
    };
  };
}
