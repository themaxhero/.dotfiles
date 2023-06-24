{ self, pkgs, config, lib, specialArgs, ... }:
with specialArgs;
let
  bin = "${pkgs.direnv}/bin/direnv";
  direnvAllow = (path: "$DRY_RUN_CMD sh -c 'if [ -f \"${path}/.envrc\" ]; then ${bin} allow \"${path}\"; fi;'");
in
{
  config = lib.mkIf nixosConfig.development.enable {
    home.packages = with pkgs; [
      ripgrep
      roboto
      scientifica
      powerline-fonts
      sshfs
      bottom
      exa
      bat
      graphviz
    ];
    # systemd.user.services.sshfs_laptop = {
    #   Unit.Description = "SSHFS to Uchigatana";
    #   Service = {
    #     ExecStart = "sshfs -o allow_other,default_permissions maxhero@192.168.0.22:/home/maxhero/projects ~/projects";
    #   };
    # };
    fonts.fontconfig.enable = true;
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };

    home.activation = {
      direnvAllow = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        ${direnvAllow "$HOME"}
      '';
    };

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
      doomPrivateDir = self + /home/maxhero/development/doom.d;
      package = pkgs.emacsGcc;
      extraPackages = [
        pkgs.nodePackages.typescript
        pkgs.nodePackages.typescript-language-server
        pkgs.nodePackages.eslint
        pkgs.metals
        pkgs.haskellPackages.lsp
      ];
      emacsPackagesOverlay = self: super: {
        magit-delta = super.magit-delta.overrideAttrs
          (esuper: { buildInputs = esuper.buildInputs ++ [
            pkgs.git
          ]; });
      };
    };

    programs.ssh.matchBlocks."github.com-mindlab" = {
      hostname = "github.com";
      user = "maxhero-mindlab";
      identityFile = "~/.ssh/mindlab_ed25519";
    };
  };
}
