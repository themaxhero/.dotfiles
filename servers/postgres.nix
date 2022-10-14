{ ... }:
{
  service.postgres = {
    enable = true;
    ensureDatabases = [
      "firefly"
    ];
    ensureUsers.firefly = {
      name = "firefly";
      ensurePermissions = {
        "DATABASE \"firefly\"" = "ALL PRIVILEGES";
        "ALL TABLES IN SCHEMA public" = "ALL PRIVILEGES";
      };
    };
  };
}