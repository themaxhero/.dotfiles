{ self, options, config, pkgs, lib, specialArgs, ... }@attrs:
let
  env = import (self + /env) attrs;
in
with pkgs.lib;
with specialArgs;
{
  home = {
    packages = with pkgs; [
      sops
      gnupg
    ];
    language = {
      base = "ja_JP.UTF-8";
      time = "ja_JP.UTF-8";
      monetary = "pt_BR.UTF-8";
      numeric = "pt_BR.UTF-8";
    };
    shellAliases = {
      edit-flake = "cd ~/flake && vim";
      start-flake-update = "cd ~/flake && git checkout -b flake-update/$(date --iso-8601) && nix flake update";
    };
  };

  programs.bat.enable = true;
  programs.bash.enable = true;
  programs.fish.enable = true;
  programs.command-not-found.enable = true;
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
  };
  programs.jq.enable = true;
  programs.lsd = {
    enable = true;
    enableAliases = true;
  };
  programs.man = {
    enable = true;
    generateCaches = true;
  };
  programs.mu.enable = true;
  programs.tealdeer.enable = true;
  programs.tmux.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "$HOME/Desktop";
    documents = "$HOME/Documents";
    download = "$HOME/Downloads";
    pictures = "$HOME/Pictures";
    publicShare = "$HOME/Public";
    templates = "$HOME/Templates";
    videos = "$HOME/Videos";
    music = "$HOME/Music";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
  };

  programs.bash.profileExtra = ''
    # Env
    ${builtins.foldl' (acc: v: "${acc}\nexport ${v.name}='${v.value}'") "" env.bash_env}
  '';
  services.lorri.enable = true;
  home.stateVersion = "21.11";
}
