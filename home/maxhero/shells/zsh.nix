{ self, options, config, pkgs, lib, specialArgs, ... }:
let
  message-of-the-day = pkgs.writeShellScript "message-of-the-day" ''
    ${pkgs.fortune}/bin/fortune |\
    ${pkgs.cowsay}/bin/cowsay -f $(${pkgs.coreutils}/bin/ls ${pkgs.cowsay}/share/cows |\
    ${pkgs.ripgrep}/bin/rg .cow |\
    ${pkgs.ripgrep}/bin/rg -v 'telebears|sodomized|mutilated|head-in|elephant-in-snake|cower|bong') |\
    ${pkgs.clolcat}/bin/clolcat
  '';
in
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    oh-my-zsh = {
      enable = true;
      theme = "lambda";
      plugins = [
        "sudo"
        "git"
        "git-extras"
        "git-flow"
        "gh"
        "rsync"
        "rust"
        "systemd"
        "torrent"
        "vscode"
        "zsh-interactive-cd"
        "zsh-navigation-tools"
        "mix"
        "vagrant"
        "ssh-agent"
      ];
      extraConfig = ''
        ${message-of-the-day}
      '';
    };
  };
}