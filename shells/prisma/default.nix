{ nixpkgs ? import <nixpkgs>, ... }:
with nixpkgs.legacyPackages.x86_64-linux;
mkShell {
  nativeBuildInputs = [ bashInteractive ];
  buildInputs = [
    prisma-engines
    openssl_1_1
    nodePackages.prisma
    nodePackages.npm
  ];
  shellHook = ''
    export PRISMA_MIGRATION_ENGINE_BINARY="${prisma-engines}/bin/migration-engine"
    export PRISMA_QUERY_ENGINE_BINARY="${prisma-engines}/bin/query-engine"
    export PRISMA_QUERY_ENGINE_LIBRARY="${prisma-engines}/lib/libquery_engine.node"
    export PRISMA_INTROSPECTION_ENGINE_BINARY="${prisma-engines}/bin/introspection-engine"
    export PRISMA_FMT_BINARY="${prisma-engines}/bin/prisma-fmt"
  '';
}
