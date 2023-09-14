{ pkgs, ... }:
{
  containers."minecraft-server-1" = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "10.255.0.1";
    localAddress = "10.255.0.2";
    forwardPorts = [
      {
        containerPort = 25565;
        hostPort = 25565;
        protocol = "tcp";
      }
    ];
    config = { pkgs, ... }: {
      services.minecraft-server = {
        enable = true;
        declarative = true;
        eula = true;
        #package = pkgs.purpur;
        openFirewall = false;
        jvmOpts = "-Xms4092M -Xmx4092M -XX:+UseG1GC -XX:+CMSIncrementalPacing -XX:+CMSClassUnloadingEnabled -XX:ParallelGCThreads=2 -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10";
        serverProperties = {
          enable-jmx-monitoring = false;
          "rcon.port" = 25575;
          enable-command-block = true;
          gamemode = "survival";
          enable-query = false;
          level-name = "world";
          motd = "P\u00C3\u0083O DE BATATA";
          "query.port" = 25565;
          pvp = true;
          generate-structures = true;
          difficulty = "normal";
          network-compression-threshold = 256;
          max-tick-time = 60000;
          require-resource-pack = false;
          max-players = 20;
          use-native-transport = true;
          online-mode = false;
          enable-status = true;
          allow-flight = false;
          broadcast-rcon-to-ops = true;
          view-distance = 10;
          max-build-height = 256;
          server-ip = "0.0.0.0";
          allow-nether = true;
          server-port = 10082;
          enable-rcon = true;
          sync-chunk-writes = true;
          op-permission-level = 4;
          server-name = "BOTEC\u00C3\u0083O DA MARISSA";
          prevent-proxy-connections = false;
          hide-online-players = false;
          entity-broadcast-range-percentage = 100;
          simulation-distance = 10;
          player-idle-timeout = 0;
          "rcon.password" = "minecraft";
          force-gamemode = false;
          debug = false;
          rate-limit = 0;
          hardcore = false;
          white-list = false;
          broadcast-console-to-ops = true;
          spawn-npcs = true;
          spawn-animals = true;
          snooper-enabled = true;
          function-permission-level = 2;
          level-type = "default";
          spawn-monsters = true;
          enforce-whitelist = false;
          spawn-protection = 16;
          max-world-size = 29999984;
        };
      };
    };
  };
}
