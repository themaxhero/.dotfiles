{ options, config, pkgs, nur, lib, home-manager, nix-doom-emacs, ... }:
with pkgs.lib;
let
  modifier = "Mod4";
  modifier2 = "Mod1";
  gtkTheme = "Orchis-Dark";
  iconTheme = "Tela-circle-dark";
  terminal = "${pkgs.alacritty}/bin/alacritty";
  discord = "${pkgs.discord}/bin/discord";
  menu = "${pkgs.wofi}/bin/wofi -I --show drun";
  editor = "${pkgs.vim}/bin/vim";
  shell = "${pkgs.zsh}/bin/zsh";
  defaultBrowser = "firefox.desktop";
  oh-my-zsh-theme = "lambda";
  lock =
    "~/.config/sway/lock.sh --indicator --indicator-radius 100 --ring-color e40000 --clock";
  zshrc = (import ./zshrc.nix) {
    inherit pkgs;
    theme = oh-my-zsh-theme;
  };
in lib.mkMerge [
  nix-doom-emacs.hmModule
  {
    options = {
      development.enable =
        lib.mkEnableOption "Enable development tools for user";
      gaming.enable = lib.mkEnableOption "Enable gaming tools for user";
      graphical-interface.enable =
        lib.mkEnableOption "Enable graphical interface for user";
    };

    config = {
      home.username = "maxhero";
      home.homeDirectory = "/home/maxhero";
      home.language = {
        base = "en_GB.UTF-8";
        time = "pt_BR.UTF-8";
        monetary = "pt_BR.UTF-8";
        numeric = "pt_BR.UTF-8";
      };

      home.file = {
        ".zshrc".text = zshrc;
        ".anthy".source = ./.anthy;
        ".wallpaper.png".source = ./.wallpaper.png;
      };

      programs.git = lib.mkIf config.development.enable {
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
            inherit editor;
          };
        };
        includes = [{
          condition = "gitdir:/home/maxhero/projects/mindlab/";
          contents = { user.email = "marcelo.amancio@mindlab.com.br"; };
        }];
      };

      programs.alacritty = lib.mkIf config.development.enable {
        enable = true;
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
          shell.program = shell;
        };
      };

      programs.doom-emacs = lib.mkIf config.development.enable {
        enable = true;
        doomPrivateDir = ./doom.d;
        emacsPackagesOverlay = self: super: {
          magit-delta = super.magit-delta.overrideAttrs
            (esuper: { buildInputs = esuper.buildInputs ++ [ pkgs.git ]; });
        };
      };

      programs.chromium = lib.mkIf config.graphical-interface.enable {
        enable = true;
        package = pkgs.ungoogled-chromium;
        extensions = [{ id = "nngceckbapebfimnlniiiahkandclblb"; }];
      };

      programs.mangohud = lib.mkIf config.gaming.enable {
        enable = true;
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

      xdg.desktopEntries = lib.mkIf config.graphical-interface.enable {
        "discord" = {
          name = "Discord (XWayland)";
          exec = "nowl ${discord}";
          terminal = false;
          categories = [ "Application" "Network" ];
        };
      };

      programs.mpv = lib.mkIf config.graphical-interface.enable {
        enable = true;
        config = {
          alang = "jpn,eng";
          slang = "jpn,eng";
          audio-channels = "stereo";
          ytdl-format = "bestvideo[height<=?1440]+bestaudio/best";
        };
      };

      home.packages = if config.graphical-interface.enable then
        (with pkgs; [
          swaynotificationcenter
          sway-launcher-desktop
          orchis-theme
          tela-circle-icon-theme
          tenacity
        ])
      else
        [ ];
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
      programs.waybar = lib.mkIf config.graphical-interface.enable {
        enable = true;
        package = pkgs.waybar;
      };
      programs.zathura.enable = config.graphical-interface.enable;
      imports = (if config.graphical-interface.enable then [
        ./waybar
        ./wofi
        ./browser
        (import ./sway {
          inherit pkgs lib modifier modifier2 gtkTheme lock menu terminal;
        })
        (import ./xdg { inherit pkgs defaultBrowser iconTheme terminal; })
        (import ./dconf { inherit lib; })
      ] else
        [ ]) ++ (if config.development.enable then [ ./emacs.nix ] else [ ]);

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
      #programs.nushell.enable = true;
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
      programs.tealdeer.enable = true;
      programs.tmux.enable = true;
      programs.zsh.oh-my-zsh.enable = true;
    };

    home.stateVersion = "21.11";
  }
]
