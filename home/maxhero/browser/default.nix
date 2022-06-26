{ pkgs, nur, lib, ... }:
{
  # TODO: Find out why this import is causing problems.
  # This import is necessary to get NUR working
  # NUR is necessary to install firefox-addons like bitwarden
  # import = (lib.attrValues nur.repos.moredhel.hmModules.modules);
  programs.firefox = {
    enable = true;
    profiles = {
      "tlb" = {
        id = 1;
        name = "tlb";
        isDefault = false;
        # extensions = with nur.repos.rycee.firefox-addons; [
        #   bitwarden
        #   1password-onepassword-password-manager
        # ];
      };
      "dea" = {
        id = 2;
        name = "dea";
        isDefault = false;
        # extensions = with nur.repos.rycee.firefox-addons; [
        #   bitwarden
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
      "firefox-tlb" = {
        name = "Firefox (TLB)";
        genericName = "Web Browser";
        exec = "${pkgs.firefox}/bin/firefox -p tlb %U";
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
      "firefox-dea" = {
        name = "Firefox (DEA)";
        genericName = "Web Browser";
        exec = "${pkgs.firefox}/bin/firefox -p dea %U";
        terminal = false;
        categories = [ "Application" "Network" "WebBrowser" ];
        icon = "firefox";
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
      "firefox" = {
        name = "Firefox (Wayland)";
        genericName = "Web Browser";
        exec = "${pkgs.firefox}/bin/firefox %U";
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
