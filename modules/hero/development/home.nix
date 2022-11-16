{ pkgs, ... }: {
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
    includes = [{
      condition = "gitdir:/home/maxhero/projects/mindlab/";
      contents = { user.email = "marcelo.amancio@mindlab.com.br"; };
    }];
  };
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
    emacsPackagesOverlay = self: super: {
      magit-delta = super.magit-delta.overrideAttrs
        (esuper: { buildInputs = esuper.buildInputs ++ [ pkgs.git ]; });
    };
  };

  programs.ssh.matchBlocks."github.com-mindlab" = {
    hostname = "github.com";
    user = "maxhero-mindlab";
    identityFile = "~/.ssh/mindlab_ed25519";
  };
}