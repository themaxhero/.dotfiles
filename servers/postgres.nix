{ ... }:
{
  services.postgresql = {
    enable = true;
    ensureDatabases = [
      "firefly"
    ];
    ensureUsers = [
      {
        name = "firefly";
        ensurePermissions = {
          "DATABASE \"firefly\"" = "ALL PRIVILEGES";
          "ALL TABLES IN SCHEMA public" = "ALL PRIVILEGES";
        };
      }
    ];
    enableTCPIP = true;
    authentication = ''
      local all all trust
      host all all ::1/128 trust
    '';
  };
}
