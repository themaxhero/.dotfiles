{ pkgs ? import <nixpkgs> { } }:
with pkgs;
devshell.mkShell { 
  name = "Maintainance Shell";

  motd = ''
  Você é que nem o carlinhos, cheio de DST!
  Maldito!
  Eu quero você longe da minha casa e dos meus filhos!
  Meus bebês mutantes que comem carne de antílope.
  '';

  env = [
    {
      name = "SHELL_VARIABLE";
      value = "1";
    }
  ];

  commands = [
    {
      name = "ru-vps";
      help = "Run update for VPS on Oracle Cloud remotely";
      category = "maintainance";
      command = "ssh -i ~/.ssh/id_ed25519 -t vps.maxhero.com.br 'sudo nixos-rebuild switch --flake github:themaxhero/.dotfiles#maxhero-vps --refresh --no-write-lock-file'";
    }
    {
      name = "upt-vps";
      help = "Run update for VPS on Oracle Cloud";
      category = "maintainance";
      command = "sudo nixos-rebuild switch --flake github:themaxhero/.dotfiles#maxhero-vps --refresh --no-write-lock-file";
    }
    {
      name = "upt-ws";
      help = "Run update for maxhero-workstation";
      category = "maintainance";
      command = "nixos-rebuild switch --use-remote-sudo";
    }
    {
      name = "upt-laptop";
      help = "Run update for uchigatana";
      category = "maintainance";
      command = "sudo nixos-rebuild switch";
    }
  ];

  packages = [

  ];
}