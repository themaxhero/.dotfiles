{ pkgs, lib, ... }:
let
  emacs = (pkgs.emacsWithPackagesFromUsePackage {
    package = pkgs.emacsGit;
    extraEmacsPackages = epkgs:
      with epkgs; [
        vterm
        magit
        org
        tide
        neotree
        hl-todo
        doom-modeline
        popup
        vi-tilde-fringe
        parinfer-rust-mode
        multiple-cursors
        consult
        embark-consult
        dockerfile-mode
        docker-compose-mode
        ansible
        editorconfig
        gist
        alchemist
      ];
  });
  vsCodeExtensions = (with pkgs.vscode-extensions; [
    {
      name = "vscode-terminals";
      publisher = "fabiospampinato";
      version = "1.13.0";
      sha256 = "0j96c6486h4073b7551xdr50fir572f22nlkz0y6q52670gdii5y";
    }
    {
      name = "vscode-mjml";
      publisher = "attilabuti";
      version = "1.6.0";
      sha256 = "180rvy17l0x5mg2nqkpfl6bcyqjnf72qknr521fmrkak2dp957yd";
    }
    {
      name = "elixir-ls";
      publisher = "JakeBecker";
      version = "0.9.0";
      sha256 = "1qz8jxpzanaccd5v68z4v1344kw0iy671ksi1bmpyavinlxdkmr8";
    }
    {
      name = "surface";
      publisher = "msaraiva";
      version = "0.7.0";
      sha256 = "1y5m0p4lkr0zfiyshrm9mkg0rzx81zhp6p16mw08jwndvy0396zn";
    }
    {
      name = "Nix";
      publisher = "bbenoist";
      version = "1.0.1";
      sha256 = "ab0c6a386b9b9507953f6aab2c5f789dd5ff05ef6864e9fe64c0855f5cb2a07d";
    }
    {
      name = "gitlens";
      publisher = "eamodio";
      version = "12.0.7";
      sha256 = "80f862cadb617f7e5e0e1b739122b62598ed8f8f3bee56b7841d42b306ebb33c";
    }
    {
      name = "vsliveshare";
      publisher = "MS-vsliveshare";
      version = "1.0.5625";
      sha256 = "053c46bc9a4e3ba7980a97a719c537d4bc84ea9baed84a993e5ddf2e5d66bc25";
    }
  ]);
  vscode-with-extensions = pkgs.vscode-with-extensions.override {
    vscodeExtensions = vsCodeExtensions;
  };
in
{
  environment.variables.EDITOR = "vim";

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

    # nix-doom-emacs.doom-emacs
    nodePackages.stylelint
    nodePackages.js-beautify
    emacs28Packages.vterm
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
  ];

  #nixpkgs.overlays = [
  #  (import (builtins.fetchTarball {
  #    url =
  #      "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
  #  }))
  #];

  services.emacs.enable = true;
  services.postgresql.enable = true;
  services.postgresql.authentication = lib.mkForce ''
    # Generated file; do not edit!
    local all all              trust
    host  all all 127.0.0.1/32 trust
    host  all all ::1/128      trust
  '';
  systemd.enableUnifiedCgroupHierarchy = true;
  virtualisation.oci-containers.backend = "podman";
  virtualisation = {
    podman = {
      enable = true;
      dockerSocket = { enable = true; };
      dockerCompat = true;
    };
  };

  # Make containers work properly
  systemd.services."user@".serviceConfig = { Delegate = "yes"; };

  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  security.pam.enableSSHAgentAuth = true;
}
