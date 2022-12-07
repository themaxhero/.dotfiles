{ config, pkgs, lib, ... }:
{
  networking = {
    hostId = "7ee3a466";
    hostName = "maxhero-w11-pc";
  };
  
  wsl = {
    enable = true;
    automountPath = "/mnt";
    defaultUser = "maxhero";
    startMenuLaunchers = true;
  };

  # Enable nix flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  environment.systemPackages = with pkgs; [
    # AWS
    awscli
    aws-iam-authenticator
    eksctl
    oci-cli

    # Cloud
    kubernetes
    minikube
    k9s

    # DotNet
    dotnet-sdk


    # Development
    google-clasp
    vscode-with-extensions
    vscodium
    dbeaver
    vim
    elmPackages.elm
    elmPackages.elm-format
    elmPackages.create-elm-app
    elmPackages.elm-language-server
    gnumake
    libtool
    libvterm
    nixpkgs-fmt
    shellcheck
    shfmt
    elixir_1_13
    yarn
    nodejs
    nushell

    inotify-tools
    chromedriver

    cmigemo
    ansible

    # rtags
    ripgrep

    nodePackages.stylelint
    nodePackages.js-beautify
    mu
    zig
    python39Packages.nose
    cargo
    rustc
    rustfmt
    rust-analyzer
    rust-code-analysis
    ocamlPackages.utop
    python3Full
    black
    icr
    fsharp
    haskellPackages.Cabal_3_6_3_0
    haskellPackages.brittany
    haskellPackages.hlint
    haskellPackages.hoogle
    haskellPackages.nixfmt
    clj-kondo
    terraform
    metals
    ruby_3_1

    chromedriver
    wireguard-tools

    racket

    podman-compose

    cmake
    gcc

    # GI
    jq
    fd
    xdelta

    # Android Stuff
    android-tools
    adbfs-rootless
  ];

  services.postgresql.enable = true;
  services.postgresql.authentication = lib.mkForce ''
    # Generated file; do not edit!
    local all all              trust
    host  all all 127.0.0.1/32 trust
    host  all all ::1/128      trust
  '';
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;
  security.pam.enableSSHAgentAuth = true;

  system.stateVersion = "22.05";
}