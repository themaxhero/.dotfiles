{ config, pkgs, home-manager, nix-doom-emacs, ... }:
{
  imports = [ nix-doom-emacs.hmModule ];
  
  programs.git = {
    enable = true;
    userName = "Marcelo Amancio de Lima Santos";
    userEmail = "contact@maxhero.dev";
    extraConfig = {
      init = { defaultBranch = "main"; };
      core = {
          excludesfile = "$NIXOS_CONFIG_DIR/scripts/gitignore";
      };
    };
  };
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
    settings = {
      window.opacity = 0.8;
      font = {
        size = 16;
        normal.family = scientifica;
        bold.family = scientifica;
        italic.family = scientifica;
        bold_italic = {
          family = scientifica;
          size = 9.0;
        };
      };
      shell.program = "${pkgs.zsh}/bin/zsh";
    };
  };
  programs.aria2.enable = true;
  programs.bat = {
    enable = true;
    themes = {
      monokai = builtins.readFile (pkgs.fetchFromGitHub {
        owner = "fnordfish";
        repo = "MonokaiMD.tmTheme";
        rev = "34ec6dc3c96d8155f4a17e1bd3edf43d27feb344";
        sha256 = "e4ee3139156415e24d9cc198ae3e621136144765e268fad597db1b525ebca4ab";
      } + "/MonokaiMD.tmTheme")
    };
  };
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };
  programs.firefox = {
    enable = true;
    enableGnomeExtensions = true;
    profiles = {
      "tl" = {
        name = "tl";
        isDefault = false;
      };
      "de" = {
        name = "de";
        isDefault = false;
      };
      "p" = {
        name = "p";
        isDefault = true;
      };
    };
  };
  programs.command-not-found.enable = true;
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./../doom.d;
  };
  programs.gpg = {
    enable = true;
  };
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };
  programs.home-manager = {
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
  ptograms.mangohud = {
    enable = true;
  };
  programs.mpv = {
    enable = true;
  };
  programs.mu.enable = true;
  programs.nushell.enable = true;
  programs.obs-studio = {
    enable = true;
  };
  programs.ssh.enable = true;
  programs.tealdeer.enable = true;
  programs.tmux.enable = true;
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    #settings = {
    #};
    #style = {
    #};
  };
  programs.zathura.enable = true;
  programs.zsh.oh-my-zsh.enable = true;
  services.blueman-applet.enable = true;
  services.gpg-agent.enable = true;
  services.mpd.enable = true;
  services.mpd-discord-rpc.enable = true;
  services.network-manager-applet.enable = true;
  services.playerctld.enable = true;
  services.swayidle = {
    enable = true;
    #timeouts = {};
  };
  dconf.settings = {
    "com/github/jkotra/eovpn" = {
      dark-theme = true;
      req-auth = false;
      show-flag = false;
    };
    
    "desktop/ibus/general" = {
      engines-order = ["xkb:us:intl" "anthy"];
      use-system-keyboard-layout = true;
    };
    
    "org/gnome/TextEditor" = {
      custom-font = "Red Hat Mono Light 16";
      highlight-current-line = false;
      indent-style = "space";
      show-grid = false;
      show-line-numbers = true;
      style-scheme = "builder-dark";
      style-variant = "dark";
      tab-width = "uint32 2";
      use-system-font = false;
    };
    
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/maxhero/.local/share/backgrounds/2022-05-06-22-36-09-.wallpaper.png";
      picture-uri-dark = "file:///home/maxhero/.local/share/backgrounds/2022-05-06-22-36-09-.wallpaper.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };
    
    "org/gnome/desktop/interface" = {
      color-scheme="prefer-dark";
      cursor-theme="Adwaita";
      font-antialiasing="grayscale";
      font-hinting="slight";
      gtk-theme="Orchis-dark";
      icon-theme = "Tela-circle-dark";
      text-scaling-factor = 1.0;
    };
    
    "org/gnome/eog/view" = {
      background-color = "rgb(0,0,0)";
      use-background-color = true;
    };
  };

  gtk = {
    cursorTheme.name = "Adwaita";
    iconTheme.package = tela-circle-icon-theme;
  };
  
  wayland.windowManager.sway = {
    enable = true;
    #package = pkgs.sway-borders;
    wrapperFeatures.gtk = true; # so that gtk works properly
    wrapperFeatures.base = true; # so that gtk works properly
    config = {
        terminal = "alacritty";
        menu = "\${pkgs.wofi}/bin/wofi -I";
        modifier = "Mod4";
        xwayland = true;
        bars = [];
        gaps.inner = 12;
        window.border = 4;
        window.titlebar = false;
        input.* = {
          xkb_layout = "us";
          xkb_variant = "intl";
          repeat_delay = 1000;
          repeat_rate = 35;
        };
        
        output = {
          DP-2 = {
            bg = "~/.wallpaper.png fill";
            pos = "0 0";
            mode = "3840x2160@60.000000hz";
          };
          DP-3 = {
            bg = "~/.wallpaper.png fill";
            pos = "3840 0";
            mode = "3840x2160@60.000000hz";
          };
          HDMI-A-1 = {
            bg = "~/.wallpaper.png fill";
          };
        };

        startup = [
            { command = "systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYLOCK"; }
            { command = "hash dbus-update-activation-environment 2>/dev/null && dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK"; }
            { command = "nm-applet --indicator"; }
            { command = "clipman"; }
            { command = "pamac-tray"; }
        ];
        #extraConfig = '' ´'';
        #extraSessionCommands = ´'' '';
    };
    xdg.mimeApps.enable = true;
    #xdg.mimeApps.associations = { added = {}; removed = {}; };
    #xdg.mimeApps.defaultApplications = {};
}
