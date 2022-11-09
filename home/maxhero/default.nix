{ pkgs, lib, nix-doom-emacs, ... }:
lib.mkMerge [
  nix-doom-emacs.hmModule
  ({ options, config, pkgs, lib, ... }:
    with pkgs.lib; {
      options = {
        development.enable = mkEnableOption "Enable development tools for user";
        gaming.enable = mkEnableOption "Enable gaming tools for user";
        graphical-interface.enable =
          mkEnableOption "Enable graphical interface for user";
      };

      config = {
        programs.git = {
          enable = config.development.enable;
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

        programs.alacritty = {
          enable = config.development.enable
            || config.graphical-interface.enable;
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

        programs.doom-emacs = {
          enable = config.development.enable;
          doomPrivateDir = ./doom.d;
          emacsPackagesOverlay = self: super: {
            magit-delta = super.magit-delta.overrideAttrs
              (esuper: { buildInputs = esuper.buildInputs ++ [ pkgs.git ]; });
          };
        };

        programs.chromium = {
          enable = config.graphical-interface.enable;
          package = pkgs.ungoogled-chromium;
          extensions = [{ id = "nngceckbapebfimnlniiiahkandclblb"; }];
        };

        programs.mangohud = {
          enable = config.gaming.enable;
          settings = {
            arch = true;
            background_alpha = "0.05";
            battery = true;
            cpu_temp = true;
            engine_version = true;
            font_size = 17;
            gl_vsync = -1;
            gpu_temp = true;
            io_read = true;
            io_write = true;
            position = "top-right";
            round_corners = 8;
            vram = true;
            vsync = 0;
            vulkan_driver = true;
            width = 260;
            wine = true;
          };
        };

        programs.mpv = {
          enable = config.graphical-interface.enable;
          config = {
            alang = "jpn,eng";
            slang = "jpn,eng";
            audio-channels = "stereo";
            ytdl-format = "bestvideo[height<=?1440]+bestaudio/best";
          };
        };

        services.blueman-applet.enable = config.graphical-interface.enable;
        services.mpd-discord-rpc.enable = config.graphical-interface.enable;
        services.network-manager-applet.enable =
          config.graphical-interface.enable;
        services.playerctld.enable = config.graphical-interface.enable;
        services.swayidle.enable = config.graphical-interface.enable;
        gtk = lib.mkIf config.graphical-interface.enable {
          cursorTheme.name = "Adwaita";
          iconTheme.package = tela-circle-icon-theme;
        };
        programs.obs-studio.enable = config.graphical-interface.enable;
        programs.waybar = {
          enable = config.graphical-interface.enable;
          package = pkgs.waybar;
        };
        programs.zathura.enable = config.graphical-interface.enable;
        programs.ssh = {
          enable = true;
          matchBlocks = {
            "github.com-mindlab" = lib.mkIf config.development.enable {
              hostname = "github.com";
              user = "maxhero-mindlab";
              identityFile = "~/.ssh/mindlab_ed25519";
            };
            "github.com" = {
              hostname = "github.com";
              user = "themaxhero";
              identityFile = "~/.ssh/id_ed25519";
            };
          };
        };
        home.file = {
          ".zshrc".text = (import ./zshrc.nix) {
            inherit pkgs;
            theme = "lambda";
          };
          ".anthy".source = ./.anthy;
          ".wallpaper.png".source = ./.wallpaper.png;
        };
      };
    })
  ./waybar
  ./wofi
  ./browser
  ./sway
  ./xdg
  ./dconf
  ({ ... }: {
    home.username = "maxhero";
    home.homeDirectory = "/home/maxhero";
    home.language = {
      base = "en_GB.UTF-8";
      time = "pt_BR.UTF-8";
      monetary = "pt_BR.UTF-8";
      numeric = "pt_BR.UTF-8";
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
  })
]
