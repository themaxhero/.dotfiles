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
  };
}