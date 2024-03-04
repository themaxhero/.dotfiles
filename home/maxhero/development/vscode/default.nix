{ pkgs ? import <nixpkgs> { }, extraExtensions ? [ ], ... }:
pkgs.vscode-with-extensions.override {
  vscodeExtensions = with pkgs.vscode-extensions; [
    bbenoist.nix
    ms-azuretools.vscode-docker
    ms-vscode-remote.remote-ssh
    ms-vsliveshare.vsliveshare
    elixir-lsp.vscode-elixir-ls
    phoenixframework.phoenix
    elmtooling.elm-ls-vscode
    mkhl.direnv
    tabnine.tabnine-vscode
    vscodevim.vim
    rust-lang.rust-analyzer
    redhat.vscode-yaml
    redhat.vscode-xml
    prisma.prisma
    ocamllabs.ocaml-platform
    ms-vscode.makefile-tools
    ms-vscode.live-server
    ms-vscode.hexeditor
    ms-ceintl.vscode-language-pack-ja
  ] ++ (pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "google-sheets-equation-syntax-hightlighter";
      publisher = "leonidasIIV";
      version = "0.1.0";
      sha256 = "sha256-JyMxX0ai4C8YYkQP71MRq+nehah+ZkBPAanFuhqj2y4=";
    }
    {
      name = "remote-ssh-edit";
      publisher = "ms-vscode-remote";
      version = "0.47.2";
      sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
    }
  ] ++ extraExtensions
  );
}
