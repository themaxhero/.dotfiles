{ options, config, pkgs, lib, specialArgs, ... }:
with pkgs.lib;
with specialArgs;
{
  home.username = "maxhero";
  home.homeDirectory = "/home/maxhero";
  home.language = {
    base = "en_GB.UTF-8";
    time = "pt_BR.UTF-8";
    monetary = "pt_BR.UTF-8";
    numeric = "pt_BR.UTF-8";
  };
  home.file = {
    ".zshrc".text = (import ./zshrc.nix) {
      inherit pkgs;
      theme = "lambda";
    };
  };
  programs.aria2.enable = true;
  programs.bat.enable = true;
  programs.fish.enable = true;
  programs.command-not-found.enable = true;
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };
  programs.home-manager.enable = true;
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
  programs.zsh.oh-my-zsh.enable = true;
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

  programs.alacritty = {
    enable = nixosConfig.development.enable || nixosConfig.graphical-interface.enable;
    package = pkgs.alacritty;
    settings = {
      window.opacity = 0.8;
      font = {
        size = 16;
        normal.family = "scientifica";
        bold.family = "scientifica";
        italic.family = "scientifica";
        bold_italic = {
          family = "scientifica";
          size = 9.0;
        };
      };
      shell.program = "${pkgs.zsh}/bin/zsh";
    };
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "themaxhero";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
  home.stateVersion = "21.11";
}
