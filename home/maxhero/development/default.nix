{ self, lib, pkgs, specialArgs, ... }@attrs:
with specialArgs;
let
  bin = "${pkgs.direnv}/bin/direnv";
  direnvAllow = (path: "$DRY_RUN_CMD sh -c 'if [ -f \"${path}/.envrc\" ]; then ${bin} allow \"${path}\"; fi;'");
  vscode-pkg =
    (pkgs.vscode-with-extensions.override {
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
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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
      ];
    });
in
{
  home.packages = with pkgs; [
    ripgrep
    roboto
    scientifica
    powerline-fonts
    sshfs
    bottom
    eza
    bat
    graphviz
    vscode-pkg
    ngrok
    insomnia
  ];

  fonts.fontconfig.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
  };

  programs.kitty = {
    enable = true;
    theme = "Monokai Classic";
    settings = {
      transparency = "yes";
      background_opacity = "0.95";
    };
  };

  programs.neovim = { enable = true; } // (self.outputs.neovimHomeManagerConfig pkgs);
  #programs.doom-emacs = { enable = true; } // (self.outputs.doomEmacsHomeManagerConfig pkgs);
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
      contents.user.email = "marcelo.amancio@mindlab.com.br";
    }];
  };

  programs.ssh.matchBlocks = {
    "github.com-mindlab" = {
      hostname = "github.com";
      user = "maxhero-mindlab";
      identityFile = "~/.ssh/mindlab_ed25519";
    };
  };
}
