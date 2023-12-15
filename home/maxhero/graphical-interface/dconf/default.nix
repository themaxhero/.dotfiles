{ specialArgs, ... }:
{
  config = lib.mkIf specialArgs.nixosConfig.graphical-interface.enable {
    dconf.settings = {
      "com/github/jkotra/eovpn" = {
        dark-theme = true;
        req-auth = false;
        show-flag = false;
      };

      "desktop/ibus/general" = {
        engines-order = [ "xkb:us:intl" "anthy" ];
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
        color-scheme = "prefer-dark";
        cursor-theme = "Adwaita";
        font-antialiasing = "grayscale";
        font-hinting = "slight";
        gtk-theme = "Orchis-dark";
        icon-theme = "Tela-circle-dark";
        text-scaling-factor = 1.0;
      };

      "org/gnome/eog/view" = {
        background-color = "rgb(0,0,0)";
        use-background-color = true;
      };
    };
  };
}
