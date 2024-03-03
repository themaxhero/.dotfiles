{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Marcelo Amancio de Lima Santos";
    userEmail = "contact@maxhero.dev";
    extraConfig = {
      rerere.enabled = true;
      pull.rebase = true;
      tag.gpgsign = true;
      init.defaultBranch = "master";
      core = {
        excludesfile = "$NIXOS_CONFIG_DIR/scripts/gitignore";
        editor = "${pkgs.vim}/bin/vim";
      };
    };
  };
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "vps.maxhero.com.br".identityFile = "~/.ssh/id_ed25519";
      "github.com" = {
        hostname = "github.com";
        user = "themaxhero";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}