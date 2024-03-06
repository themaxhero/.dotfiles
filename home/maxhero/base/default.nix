{ self, options, config, pkgs, lib, specialArgs, ... }:
with pkgs.lib;
with specialArgs;
{
  home = {
    packages = with pkgs; [
      sops
      gnupg
    ];
    language = {
      base = "en_GB.UTF-8";
      time = "pt_BR.UTF-8";
      monetary = "pt_BR.UTF-8";
      numeric = "pt_BR.UTF-8";
    };
  };

  programs.bat.enable = true;
  programs.fish.enable = true;
  programs.command-not-found.enable = true;
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
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
  home.stateVersion = "21.11";
}
