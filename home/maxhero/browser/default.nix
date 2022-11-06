{ pkgs, nur, lib, ... }:
let
  firefox = "${pkgs.firefox}/bin/firefox";
in
{
  # TODO: Find out why this import is causing problems.
  # This import is necessary to get NUR working
  # NUR is necessary to install firefox-addons like bitwarden
  # import = (lib.attrValues nur.repos.moredhel.hmModules.modules);
  programs.firefox = {
    enable = true;
    profiles = {
      "mindlab" = {
        id = 1;
        name = "mindlab";
        isDefault = false;
        # extensions = with nur.repos.rycee.firefox-addons; [
        #   bitwarden
        #   1password-onepassword-password-manager
        # ];
      };
      "p" = {
        id = 0;
        name = "p";
        isDefault = true;
        # extensions = with nur.repos.rycee.firefox-addons; [
        #   bitwarden
        # ];
      };
    };
  };

  # Create Firefox .desktop for each profile
  xdg = {
    desktopEntries = {
      "firefox-mindlab" = {
        name = "Firefox (Wayland - Profile: MindLab)";
        genericName = "Web Browser";
        exec = "${firefox} -p mindlab %U";
        terminal = false;
        icon = "firefox";
        categories = [ "Application" "Network" "WebBrowser" ];
        type = "Application";
      };
      "firefox" = {
        name = "Firefox (Wayland)";
        genericName = "Web Browser";
        exec = "${firefox} %U";
        terminal = false;
        icon = "firefox";
        categories = [ "Application" "Network" "WebBrowser" ];
        mimeType = [
          "application/pdf"
          "application/vnd.mozilla.xul+xml"
          "application/xhtml+xml"
          "text/html"
          "text/xml"
          "x-scheme-handler/http"
          "x-scheme-handler/https"
        ];
        type = "Application";
      };
    };
  };
}
