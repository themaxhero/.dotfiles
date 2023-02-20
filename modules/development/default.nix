{ config, pkgs, lib, ... }:
let
  cfg = config.development;
  conditional-lang = x: y: if builtins.elem x cfg.development.languages then y else [];
  laguages = with pkgs; (
    [
      mu
      python39Packages.nose
      python3Full
      ripgrep
      cmigemo
      black
      nushell
      dbeaver
      vim
      gnumake
      libtool
      libvterm
      nixpkgs-fmt
      spellcheck
      shfmt
      wireguard-tools
      racket
      podman-compose
      cmake
      gcc
      jq
      fd
      xdelta
    ]
    ++ (conditional-lang "dotnet" [
      dotnet-sdk
    ])
    ++ (conditional-lang "crystal" [
      icr
    ])
    ++ (conditional-lang "f#" [
      fsharp
    ])
    ++ (conditional-lang "ocaml" [
      ocamlPackages.utop
    ])
    ++ (conditional-lang "elm" [
      elmPackages.elm
      elmPackages.elm-format
      elmPackages.create-elm-app
      elmPackages.elm-language-server
    ])
    ++ (conditional-lang "elixir" [
      elixir_1_14
      inotify-tools
    ])
    ++ (conditional-lang "web" [
      yarn
      chromedriver
    ])
    ++ (conditional-lang "zig" [
      zig
    ])
    ++ (conditional-lang "node" [
      nodejs
      nodePackages.stylelint
      nodePackages.js-beautify
      yarn
    ])
    ++ (conditional-lang "ruby" [
      ruby_3_1
    ])
    ++ (conditional-lang "scala" [
      metals
    ])
    ++ (conditional-lang "haskell" [
      # Haskell Libraries
      #haskellPackages.Cabal_3_6_3_0
      #haskellPackages.brittany
      #haskellPackages.hlint
      #haskellPackages.hoogle
      #haskellPackages.nixfmt
    ])
    ++ (conditional-lang "clojure" [
      clj-kondo
    ])
    ++ (conditional-lang "rust" [
      cargo
      rustc
      rustfmt
      rust-analyzer
      rust-code-analysis
    ])
    ++ (conditional-lang "android" [
      android-tools
      adbfs-rootless
    ])
    ++ (conditional-lang "aws" [
      awscli
      aws-iam-authenticator
      eksctl
      (kubernetes-helm-wrapped = pkgs.wrapHelm pkgs.kubernetes-helm {
        plugins = with pkgs.kubernetes-helmPlugins; [ helm-diff ];
      })
    ])
    ++ (conditional-lang "clasp" [
      google-clasp
    ])
    ++ (conditional-lang "oracle-cloud" [
      oci-cli
    ])
    ++ (conditional-lang "devops" [
      terraform
      ansible
    ])
    ++ (conditional-lang "kubernetes" [
      kubernetes
      kubernetes-helm-wrapped
      minikube
      k9s
    ])
  );
in
{
  config = mkIf cfg.enable {
    options.environment.systemPackages = languages;
    services.postgresql.enable = true;
    services.postgresql.package = pkgs.postgresql_14;
    services.postgresql.authentication = lib.mkForce ''
      # Generated file; do not edit!
      local all all              trust
      host  all all 192.168.0.88/32 trust
      host  all all 127.0.0.1/32 trust
      host  all all ::1/128      trust
    '';
    services.postgresql.settings.listen_addresses = lib.mkForce "*";
    systemd.enableUnifiedCgroupHierarchy = true;
    virtualisation.oci-containers = {
      backend = "podman";
      containers = {
        code-server = {
          image = "codercom/code-server";
          ports = ["7654:8080"];
          volumes = [
            "/home/maxhero/projects/:/home/coder/project/"
            "/home/maxhero/.config:/home/coder/.config"
          ];
          environment = {
            PASSWORD = "code-space-666";
          };
          cmd = ["code-server --allow-http --auth password"];
        };
      };
    };
    virtualisation.podman = {
      enable = true;
      dockerSocket.enable = true;
      dockerCompat = true;
    };

    # Make containers work properly
    systemd.services."user@".serviceConfig.Delegate = "yes";
    programs.gnupg.agent.enable = true;
    programs.gnupg.agent.enableSSHSupport = true;
    security.pam.enableSSHAgentAuth = true;
  };
}