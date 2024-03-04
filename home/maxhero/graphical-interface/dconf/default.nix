{ lib, specialArgs, ... }:
{
  dconf.settings = {
    "com/github/jkotra/eovpn" = {
      dark-theme = true;
      req-auth = false;
      show-flag = false;
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

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Adwaita";
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      text-scaling-factor = 1.0;
    };

    "org/gnome/eog/view" = {
      background-color = "rgb(0,0,0)";
      use-background-color = true;
    };
  };
}
