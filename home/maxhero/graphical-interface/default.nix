{ self, config, pkgs, lib, specialArgs, nur, ... }:
with specialArgs;
let
  lxqt-sudo = "${pkgs.lxqt.lxqt-sudo}/bin/lxqt-sudo";
  nm-applet = "${pkgs.networkmanagerapplet}/bin/nm-applet";
  isUchigatana = nixosConfig.networking.hostName == "uchigatana";
  fontSize = if isUchigatana then 16 else 24;
  nordvpn-proxy-extension = pkgs.nur.repos.rycee.firefox-addons.buildFirefoxXpiAddon {
    pname = "nordvpn-proxy-extension";
    version = "3.7.3";
    url = "https://addons.mozilla.org/firefox/downloads/file/4211396/nordvpn_proxy_extension-3.7.3.xpi";
    sha256 = "sha256-TkBzVuoDzEs1kvXZFCCSkiYk7OVxPlD3aTgyfKsT4RU=";
    addonId = "c0a2a013-bb0b-463b-930f-3d51c02ad1d6";
    meta = with lib; {
      homepage = "https://nordvpn.com/pt-br/";
      description = "With this proxy extension, you can stay secure and private on the Internet and avoid those annoying online ads.";
      mozPermissions = [
        "proxy"
        "webRequest"
        "webRequestBlocking"
        "privacy"
        "<all_urls>"
        "storage"
        "notifications"
        "tabs"
        "contextMenus"
      ];
      platforms = platforms.all;
    };
  };
  colorful-abstract-neon = pkgs.nur.repos.rycee.firefox-addons.buildFirefoxXpiAddon {
    pname = "colorful-abstract-neon";
    version = "2.0";
    url = "https://addons.mozilla.org/firefox/downloads/file/4132427/colorful_abstract_neon-2.0.xpi";
    sha256 = "sha256-ezLRlqY3FjUyIAWupXQWf4RLJGrBmHVzgaSfQd1lhLQ=";
    addonId = "a0a62451-eee1-403f-96e9-0df2da243832";
    meta = with lib; {
      homepage = "mailto:alifrfx@gmail.com";
      description = "colorful, geometric, abstract, neon";
      mozPermissions = [
        "theme"
      ];
      platforms = platforms.all;
    };
  };
in
{
  home = {
    packages = with pkgs; [
      anki
      veracrypt
      bitwarden-desktop
      orchis-theme
      tela-circle-icon-theme
      youtube-dl
      sublime
      nomacs
      wpsoffice
    ];
    file = {
      ".anthy".source = self + /home/maxhero/graphical-interface/.anthy;
      ".uim.d".source = ./.uim.d;
      ".wallpaper.jpg".source = self + /home/maxhero/graphical-interface/.wallpaper.jpg;
      ".wallpaper.png".source = self + /home/maxhero/graphical-interface/.wallpaper.png;
    };
  };

  programs.firefox = {
    enable = true;
    profiles = {
      "p" = {
        id = 0;
        name = "p";
        bookmarks = [
          {
            name = "Home Manager Option Search";
            tags = [ "nix" ];
            keyword = "nix";
            url = "https://home-manager-options.extranix.com/";
          }
          {
            name = "Home Manager Option Docs";
            tags = [ "nix" ];
            keyword = "nix";
            url = "https://nix-community.github.io/home-manager/options.xhtml";
          }
        ];
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          mal-sync
          darkreader
          multi-account-containers
          nordvpn-proxy-extension
          colorful-abstract-neon
        ];
        settings = {
          "accessibility.typeaheadfind.flashBar" = 0;
          "browser.bookmarks.addedImportButton" = true;
          "browser.bookmarks.restore_default_bookmarks" = false;
          "browser.contentblocking.category" = "standard";
          "browser.contentblocking.cfr-milestone.milestone-achieved" = 10000;
          "browser.contentblocking.cfr-milestone.milestone-shown-time" = "1706765374495";
          "browser.download.panel.shown" = true;
          "browser.download.viewableInternally.typeWasRegistered.avif" = true;
          "browser.download.viewableInternally.typeWasRegistered.webp" = true;
          "browser.eme.ui.firstContentShown" = true;
          "browser.engagement.ctrlTab.has-used" = true;
          "browser.engagement.downloads-button.has-used" = true;
          "browser.engagement.fxa-toolbar-menu-button.has-used" = true;
          "browser.pageActions.persistedActions" = "{\"ids\":[\"bookmark\",\"_testpilot-containers\"],\"idsInUrlbar\":[\"_testpilot-containers\",\"bookmark\"],\"idsInUrlbarPreProton\":[],\"version\":1}";
          "browser.pagethumbnails.storage_version" = 3;
          "browser.policies.applied" = true;
          "browser.protections_panel.infoMessage.seen" = true;
          "browser.proton.toolbar.version" = 3;
          "browser.rights.3.shown" = true;
          "browser.search.region" = "BR";
          "browser.sessionstore.upgradeBackup.latestBuildID" = "20240213221259";
          "browser.shell.defaultBrowserCheckCount" = 37;
          "browser.shell.didSkipDefaultBrowserCheckOnFirstRun" = true;
          "browser.startup.couldRestoreSession.count" = 2;
          "browser.startup.homepage_override.buildID" = "20240213221259";
          "browser.startup.homepage_override.mstone" = "123.0";
          "browser.theme.toolbar-theme" = 0;
          "browser.translations.panelShown" = true;
          "browser.uiCustomization.state" = "{\"placements\":{\"widget-overflow-fixed-list\":[\"firefox-view-button\"],\"unified-extensions-area\":[],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"urlbar-container\",\"customizableui-special-spring2\",\"save-to-pocket-button\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action\",\"unified-extensions-button\",\"addon_darkreader_org-browser-action\",\"_testpilot-containers-browser-action\",\"nordvpnproxy_nordvpn_com-browser-action\",\"reset-pbm-toolbar-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"import-button\",\"personal-bookmarks\"]},\"seen\":[\"save-to-pocket-button\",\"developer-button\",\"_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action\",\"addon_darkreader_org-browser-action\",\"_testpilot-containers-browser-action\",\"nordvpnproxy_nordvpn_com-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"PersonalToolbar\",\"toolbar-menubar\",\"TabsToolbar\",\"unified-extensions-area\",\"widget-overflow-fixed-list\"],\"currentVersion\":20,\"newElementCount\":2}";
          "browser.urlbar.placeholderName" = "Google";
          "browser.urlbar.placeholderName.private" = "Google";
          "browser.urlbar.quicksuggest.migrationVersion" = 2;
          "browser.urlbar.quicksuggest.scenario" = "history";
          "browser.urlbar.tabToSearch.onboard.interactionsLeft" = 1;
          "browser.urlbar.tipShownCount.searchTip_onboard" = 4;
          "browser.urlbar.tipShownCount.searchTip_redirect" = 4;
          "browser.warnOnQuitShortcut" = false;
          "datareporting.policy.dataSubmissionPolicyAcceptedVersion" = 2;
          "datareporting.policy.dataSubmissionPolicyNotifiedTime" = "1681835524750";
          "devtools.cache.disabled" = true;
          "devtools.debugger.pending-selected-location" = "{\"url\":\"https://web.cornershopapp.com/vendors~main.d4534b71deb22767cfa2.js:formatted\",\"line\":9822,\"column\":25}";
          "devtools.debugger.prefs-schema-version" = 11;
          "devtools.everOpened" = true;
          "devtools.netmonitor.columnsData" = "[{\"name\":\"status\",\"minWidth\":30,\"width\":6.67},{\"name\":\"method\",\"minWidth\":30,\"width\":6.67},{\"name\":\"domain\",\"minWidth\":30,\"width\":13.32},{\"name\":\"file\",\"minWidth\":30,\"width\":33.35},{\"name\":\"url\",\"minWidth\":30,\"width\":25},{\"name\":\"initiator\",\"minWidth\":30,\"width\":13.32},{\"name\":\"type\",\"minWidth\":30,\"width\":6.67},{\"name\":\"transferred\",\"minWidth\":30,\"width\":13.34},{\"name\":\"contentSize\",\"minWidth\":30,\"width\":6.67},{\"name\":\"waterfall\",\"minWidth\":150,\"width\":3.7}]";
          "devtools.netmonitor.msg.visibleColumns" = "[\"data\",\"time\"]";
          "devtools.netmonitor.panes-network-details-width" = 1535;
          "devtools.performance.recording.features" = "[\"screenshots\",\"js\",\"cpu\"]";
          "devtools.performance.recording.threads" = "[\"GeckoMain\",\"Compositor\",\"Renderer\",\"DOM Worker\"]";
          "devtools.responsive.html.displayedDeviceList" = "{\"added\":[\"Pixel 2 XL\",\"Laptop with HiDPI screen\",\"Laptop with MDPI screen\",\"Laptop with touch\",\"1080p Full HD Television\",\"4K Ultra HD Television\",\"720p HD Television\"],\"removed\":[]}";
          "devtools.responsive.reloadNotification.enabled" = false;
          "devtools.responsive.touchSimulation.enabled" = true;
          "devtools.responsive.userAgent" = "Mozilla/5.0 (Linux; Android 8.0.0; Pixel 2 XL Build/OPD1.170816.004) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Mobile Safari/537.36";
          "devtools.responsive.viewport.height" = 823;
          "devtools.responsive.viewport.pixelRatio" = 3;
          "devtools.responsive.viewport.width" = 411;
          "devtools.selfxss.count" = 2;
          "devtools.toolbox.footer.height" = 943;
          "devtools.toolbox.selectedTool" = "netmonitor";
          "devtools.toolsidebar-height.inspector" = 350;
          "devtools.toolsidebar-width.inspector" = 700;
          "devtools.toolsidebar-width.inspector.splitsidebar" = 350;
          "distribution.iniFile.exists.appversion" = "123.0";
          "distribution.iniFile.exists.value" = true;
          "distribution.nixos.bookmarksProcessed" = true;
          "doh-rollout.disable-heuristics" = true;
          "doh-rollout.doneFirstRun" = true;
          "doh-rollout.home-region" = "BR";
          "dom.push.userAgentID" = "c5025f3f606f4b64bf3edc60468c23fc";
          "extensions.activeThemeID" = "{9fd56529-f621-4820-8128-f0bbbdbd8a73}";
          "extensions.blocklist.pingCountVersion" = -1;
          "extensions.databaseSchema" = 35;
          "extensions.getAddons.databaseSchema" = 6;
          "extensions.pendingOperations" = false;
          "extensions.pictureinpicture.enable_picture_in_picture_overrides" = true;
          "extensions.quarantinedDomains.list" = "autoatendimento.bb.com.br,ibpf.sicredi.com.br,ibpj.sicredi.com.br,internetbanking.caixa.gov.br,www.ib12.bradesco.com.br,www2.bancobrasil.com.br";
          "extensions.recommendations.hideNotice" = true;
          "extensions.systemAddonSet" = "{\"schema\":1,\"addons\":{}}";
          "extensions.ui.dictionary.hidden" = false;
          "extensions.ui.extension.hidden" = false;
          "extensions.ui.locale.hidden" = false;
          "extensions.ui.sitepermission.hidden" = true;
          "extensions.ui.theme.hidden" = false;
          "findbar.highlightAll" = true;
          "font.minimum-size.x-western" = 12;
          "gecko.handlerService.defaultHandlersVersion" = 1;
          "intl.locale.requested" = "ja,en-US";
          "layout.css.prefers-color-scheme.content-override" = 0;
          "media.eme.enabled" = true;
          "media.gmp.storage.version.observed" = 1;
          "media.videocontrols.picture-in-picture.video-toggle.has-used" = true;
          "network.trr.mode" = 2;
          "network.trr.uri" = "https://mozilla.cloudflare-dns.com/dns-query";
          "nimbus.syncdefaultsstore.upgradeDialog" = "{\"slug\":\"upgrade-spotlight-rollout\",\"branch\":{\"slug\":\"treatment\",\"ratio\":1,\"feature\":{\"value\":null,\"enabled\":true,\"featureId\":\"upgradeDialog\"},\"features\":null},\"active\":true,\"enrollmentId\":\"e0366b3a-acf7-41c7-8bdc-2394509a6502\",\"experimentType\":\"rollout\",\"source\":\"rs-loader\",\"userFacingName\":\"Upgrade Spotlight Rollout\",\"userFacingDescription\":\"Experimenting on onboarding content when you upgrade Firefox.\",\"lastSeen\":\"2023-09-06T21:27:38.534Z\",\"featureIds\":[\"upgradeDialog\"],\"prefs\":[],\"isRollout\":true}";
          "nimbus.syncdefaultsstore.upgradeDialog.enabled" = false;
          "pdfjs.enabledCache.state" = true;
          "pdfjs.migrationVersion" = 2;
          "pref.privacy.disable_button.tracking_protection_exceptions" = false;
          "print.more-settings.open" = true;
          "print.printer_Mozilla_Save_to_PDF.print_bgcolor" = true;
          "print.printer_Mozilla_Save_to_PDF.print_bgimages" = true;
          "print.printer_Mozilla_Save_to_PDF.print_footercenter" = "";
          "print.printer_Mozilla_Save_to_PDF.print_footerleft" = "";
          "print.printer_Mozilla_Save_to_PDF.print_footerright" = "";
          "print.printer_Mozilla_Save_to_PDF.print_headercenter" = "";
          "print.printer_Mozilla_Save_to_PDF.print_headerleft" = "";
          "print.printer_Mozilla_Save_to_PDF.print_headerright" = "";
          "print.printer_Mozilla_Save_to_PDF.print_ignore_unwriteable_margins" = true;
          "print.printer_Mozilla_Save_to_PDF.print_margin_bottom" = "0";
          "print.printer_Mozilla_Save_to_PDF.print_margin_left" = "0";
          "print.printer_Mozilla_Save_to_PDF.print_margin_right" = "0";
          "print.printer_Mozilla_Save_to_PDF.print_margin_top" = "0";
          "print.printer_Mozilla_Save_to_PDF.print_orientation" = 0;
          "print.printer_Mozilla_Save_to_PDF.print_paper_height" = "14";
          "print.printer_Mozilla_Save_to_PDF.print_paper_id" = "na_legal";
          "print.printer_Mozilla_Save_to_PDF.print_paper_size_unit" = 0;
          "print.printer_Mozilla_Save_to_PDF.print_paper_width" = "8.5";
          "print.printer_Mozilla_Save_to_PDF.print_unwriteable_margin_bottom_twips" = 0;
          "print.printer_Mozilla_Save_to_PDF.print_unwriteable_margin_left_twips" = 0;
          "print.printer_Mozilla_Save_to_PDF.print_unwriteable_margin_right_twips" = 0;
          "print.printer_Mozilla_Save_to_PDF.print_unwriteable_margin_top_twips" = 0;
          "print_printer" = "Mozilla Save to PDF";
          "privacy.purge_trackers.date_in_cookie_database" = "0";
          "privacy.userContext.enabled" = true;
          "privacy.userContext.extension" = "@testpilot-containers";
          "privacy.userContext.ui.enabled" = true;
          "security.sandbox.content.tempDirSuffix" = "936c414c-786e-413f-a579-68091311d773";
          "services.settings.clock_skew_seconds" = 1;
          "trailhead.firstrun.didSeeAboutWelcome" = true;
        };
        isDefault = true;
      };
    };
  };

  services.easyeffects.enable = true;

  programs.alacritty = {
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
      shell.program = "${pkgs.zsh}/bin/zsh";
    };
  };

  programs.kitty = {
    enable = true;
    theme = "Monokai Classic";
    settings = {
      transparency = "yes";
      background_opacity = "0.95";
      confirm_os_window_close = "0";
    };
  };

  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    extensions = [{ id = "nngceckbapebfimnlniiiahkandclblb"; }];
  };

  programs.mpv = {
    enable = true;
    config = {
      alang = "jpn,eng";
      slang = "jpn,eng";
      audio-channels = "stereo";
      ytdl-format = "bestvideo[height<=?1440]+bestaudio/best";
    };
  };

  services.blueman-applet.enable = true;
  services.mpd-discord-rpc.enable = true;
  services.network-manager-applet.enable = true;
  services.playerctld.enable = true;
  services.picom = {
    enable = true;
    vSync = true;
  };

  gtk = {
    enable = true;
    cursorTheme.name = "Adwaita";
    iconTheme = {
      name = "Tela-circle-dark";
      package = pkgs.tela-circle-icon-theme;
    };
    theme = {
      name = "Orchis-Dark";
      package = pkgs.orchis-theme;
    };
  };

  qt = {
    enable = true;
    style.name = "adwaita-dark";
  };

  programs.obs-studio.enable = true;
  programs.zathura.enable = true;

  # I'm so happy that I found uim
  i18n.inputMethod.enabled = "uim";

  ewwConfig.enable = true;
  rofiConfig = {
    enable = true;
    style = 1;
    type = 6;
    color = "onedark";
  };

  # Create Firefox .desktop for each profile
  xdg = {
    desktopEntries = {
      reboot = {
        name = "Reboot";
        exec = "${lxqt-sudo} reboot";
        icon =
          "${pkgs.tela-circle-icon-theme}/share/icons/Tela-circle-dark/scalable@2x/apps/xfsm-reboot.svg";
        terminal = false;
      };
      windows = {
        name = "Windows";
        exec = "sudo ${(pkgs.callPackage (self + /pkgs/reboot-to-windows.nix) {})}/bin/reboot-to-windows";
        icon =
          "${pkgs.tela-circle-icon-theme}/share/icons/Tela-circle-dark/scalable@2x/apps/xfsm-reboot.svg";
        terminal = false;
      };
      firefox = {
        name = "Firefox";
        genericName = "Web Browser";
        exec = "${pkgs.firefox}/bin/firefox -p p %U";
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
          "application/x-extension-htm"
          "application/x-extension-html"
          "application/x-extension-shtml"
          "application/x-extension-xhtml"
          "application/x-extension-xht"
        ];
        type = "Application";
      };
    };

    # Need to solve this later for better looking stuff
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/epub+zip" = "xarchiver.desktop";
        "application/x-7z-compressed" = "xarchiver.desktop";
        "application/x-7z-compressed-tar" = "xarchiver.desktop";
        "application/x-ace" = "xarchiver.desktop";
        "application/x-alz" = "xarchiver.desktop";
        "application/x-arc" = "xarchiver.desktop";
        "application/x-arj" = "xarchiver.desktop";
        "application/x-brotli" = "xarchiver.desktop";
        "application/x-brotli-compressed-tar" = "xarchiver.desktop";
        "application/x-bzip" = "xarchiver.desktop";
        "application/x-bzip2" = "xarchiver.desktop";
        "application/bzip2" = "xarchiver.desktop";
        "application/x-bzip-compressed-tar" = "xarchiver.desktop";
        "application/x-bzip1" = "xarchiver.desktop";
        "application/x-bzip1-compressed-tar" = "xarchiver.desktop";
        "application/x-cabinet" = "xarchiver.desktop";
        "application/x-cbr" = "xarchiver.desktop";
        "application/x-cbz" = "xarchiver.desktop";
        "application/x-cd-image" = "xarchiver.desktop";
        "application/x-compress" = "xarchiver.desktop";
        "application/x-compressed-tar" = "xarchiver.desktop";
        "application/x-cpio" = "xarchiver.desktop";
        "application/vnd.debian.binary-package" = "xarchiver.desktop";
        "application/x-ear" = "xarchiver.desktop";
        "application/x-ms-dos-executable" = "xarchiver.desktop";
        "application/x-gtar" = "xarchiver.desktop";
        "application/x-gzip" = "xarchiver.desktop";
        "application/gzip" = "xarchiver.desktop";
        "application/x-gzpostscript" = "xarchiver.desktop";
        "application/x-java-archive" = "xarchiver.desktop";
        "application/x-lha" = "xarchiver.desktop";
        "application/x-lzh-compressed" = "xarchiver.desktop";
        "application/x-lrzip" = "xarchiver.desktop";
        "application/x-lrzip-compressed-tar" = "xarchiver.desktop";
        "application/x-lzip" = "xarchiver.desktop";
        "application/x-lzip-compressed-tar" = "xarchiver.desktop";
        "application/x-lzma" = "xarchiver.desktop";
        "application/x-lzma-compressed-tar" = "xarchiver.desktop";
        "application/x-lzop" = "xarchiver.desktop";
        "application/x-lzop-compressed-tar" = "xarchiver.desktop";
        "application/x-ms-wim" = "xarchiver.desktop";
        "application/x-rar" = "xarchiver.desktop";
        "application/x-rar-compressed" = "xarchiver.desktop";
        "application/x-rpm" = "xarchiver.desktop";
        "application/x-source-rpm" = "xarchiver.desktop";
        "application/x-rzip" = "xarchiver.desktop";
        "application/x-tar" = "xarchiver.desktop";
        "application/x-tarz" = "xarchiver.desktop";
        "application/x-stuffit" = "xarchiver.desktop";
        "application/x-war" = "xarchiver.desktop";
        "application/x-xz" = "xarchiver.desktop";
        "application/x-xz-compressed-tar" = "xarchiver.desktop";
        "application/x-zip" = "xarchiver.desktop";
        "application/x-zip-compressed" = "xarchiver.desktop";
        "application/x-zoo" = "xarchiver.desktop";
        "application/zstd" = "xarchiver.desktop";
        "application/x-zstd" = "xarchiver.desktop";
        "application/x-zstd-compressed-tar" = "xarchiver.desktop";
        "application/zip" = "xarchiver.desktop";
        "application/x-archive" = "xarchiver.desktop";
        "application/vnd.ms-cab-compressed" = "xarchiver.desktop";
        "inode/directory" = "org.kde.dolphin.desktop";
        "application/pdf" = "firefox.desktop";
        "application/vnd.mozilla.xul+xml" = "firefox.desktop";
        "application/xhtml+xml" = "firefox.desktop";
        "text/html" = "firefox.desktop";
        "text/xml" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "application/x-extension-htm" = "firefox.desktop";
        "application/x-extension-html" = "firefox.desktop";
        "application/x-extension-shtml" = "firefox.desktop";
        "application/x-extension-xhtml" = "firefox.desktop";
        "application/x-extension-xht" = "firefox.desktop";
        "image/png" = "org.nomacs.ImageLounge.desktop";
        "image/jpeg" = "org.nomacs.ImageLounge.desktop";
        "application/ogg" = "mpv.desktop";
        "application/x-ogg" = "mpv.desktop";
        "application/mxf" = "mpv.desktop";
        "application/sdp" = "mpv.desktop";
        "application/smil" = "mpv.desktop";
        "application/x-smil" = "mpv.desktop";
        "application/streamingmedia" = "mpv.desktop";
        "application/x-streamingmedia" = "mpv.desktop";
        "application/vnd.rn-realmedia" = "mpv.desktop";
        "application/vnd.rn-realmedia-vbr" = "mpv.desktop";
        "audio/aac" = "mpv.desktop";
        "audio/x-aac" = "mpv.desktop";
        "audio/vnd.dolby.heaac.1" = "mpv.desktop";
        "audio/vnd.dolby.heaac.2" = "mpv.desktop";
        "audio/aiff" = "mpv.desktop";
        "audio/x-aiff" = "mpv.desktop";
        "audio/m4a" = "mpv.desktop";
        "audio/x-m4a" = "mpv.desktop";
        "application/x-extension-m4a" = "mpv.desktop";
        "audio/mp1" = "mpv.desktop";
        "audio/x-mp1" = "mpv.desktop";
        "audio/mp2" = "mpv.desktop";
        "audio/x-mp2" = "mpv.desktop";
        "audio/mp3" = "mpv.desktop";
        "audio/x-mp3" = "mpv.desktop";
        "audio/mpeg" = "mpv.desktop";
        "audio/mpeg2" = "mpv.desktop";
        "audio/mpeg3" = "mpv.desktop";
        "audio/mpegurl" = "mpv.desktop";
        "audio/x-mpegurl" = "mpv.desktop";
        "audio/mpg" = "mpv.desktop";
        "audio/x-mpg" = "mpv.desktop";
        "audio/rn-mpeg" = "mpv.desktop";
        "audio/musepack" = "mpv.desktop";
        "audio/x-musepack" = "mpv.desktop";
        "audio/ogg" = "mpv.desktop";
        "audio/scpls" = "mpv.desktop";
        "audio/x-scpls" = "mpv.desktop";
        "audio/vnd.rn-realaudio" = "mpv.desktop";
        "audio/wav" = "mpv.desktop";
        "audio/x-pn-wav" = "mpv.desktop";
        "audio/x-pn-windows-pcm" = "mpv.desktop";
        "audio/x-realaudio" = "mpv.desktop";
        "audio/x-pn-realaudio" = "mpv.desktop";
        "audio/x-ms-wma" = "mpv.desktop";
        "audio/x-pls" = "mpv.desktop";
        "audio/x-wav" = "mpv.desktop";
        "video/mpeg" = "mpv.desktop";
        "video/x-mpeg2" = "mpv.desktop";
        "video/x-mpeg3" = "mpv.desktop";
        "video/mp4v-es" = "mpv.desktop";
        "video/x-m4v" = "mpv.desktop";
        "video/mp4" = "mpv.desktop";
        "application/x-extension-mp4" = "mpv.desktop";
        "video/divx" = "mpv.desktop";
        "video/vnd.divx" = "mpv.desktop";
        "video/msvideo" = "mpv.desktop";
        "video/x-msvideo" = "mpv.desktop";
        "video/ogg" = "mpv.desktop";
        "video/quicktime" = "mpv.desktop";
        "video/vnd.rn-realvideo" = "mpv.desktop";
        "video/x-ms-afs" = "mpv.desktop";
        "video/x-ms-asf" = "mpv.desktop";
        "audio/x-ms-asf" = "mpv.desktop";
        "application/vnd.ms-asf" = "mpv.desktop";
        "video/x-ms-wmv" = "mpv.desktop";
        "video/x-ms-wmx" = "mpv.desktop";
        "video/x-ms-wvxvideo" = "mpv.desktop";
        "video/x-avi" = "mpv.desktop";
        "video/avi" = "mpv.desktop";
        "video/x-flic" = "mpv.desktop";
        "video/fli" = "mpv.desktop";
        "video/x-flc" = "mpv.desktop";
        "video/flv" = "mpv.desktop";
        "video/x-flv" = "mpv.desktop";
        "video/x-theora" = "mpv.desktop";
        "video/x-theora+ogg" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop";
        "video/mkv" = "mpv.desktop";
        "audio/x-matroska" = "mpv.desktop";
        "application/x-matroska" = "mpv.desktop";
        "video/webm" = "mpv.desktop";
        "audio/webm" = "mpv.desktop";
        "audio/vorbis" = "mpv.desktop";
        "audio/x-vorbis" = "mpv.desktop";
        "audio/x-vorbis+ogg" = "mpv.desktop";
        "video/x-ogm" = "mpv.desktop";
        "video/x-ogm+ogg" = "mpv.desktop";
        "application/x-ogm" = "mpv.desktop";
        "application/x-ogm-audio" = "mpv.desktop";
        "application/x-ogm-video" = "mpv.desktop";
        "application/x-shorten" = "mpv.desktop";
        "audio/x-shorten" = "mpv.desktop";
        "audio/x-ape" = "mpv.desktop";
        "audio/x-wavpack" = "mpv.desktop";
        "audio/x-tta" = "mpv.desktop";
        "audio/AMR" = "mpv.desktop";
        "audio/ac3" = "mpv.desktop";
        "audio/eac3" = "mpv.desktop";
        "audio/amr-wb" = "mpv.desktop";
        "video/mp2t" = "mpv.desktop";
        "audio/flac" = "mpv.desktop";
        "audio/mp4" = "mpv.desktop";
        "application/x-mpegurl" = "mpv.desktop";
        "video/vnd.mpegurl" = "mpv.desktop";
        "application/vnd.apple.mpegurl" = "mpv.desktop";
        "audio/x-pn-au" = "mpv.desktop";
        "video/3gp" = "mpv.desktop";
        "video/3gpp" = "mpv.desktop";
        "video/3gpp2" = "mpv.desktop";
        "audio/3gpp" = "mpv.desktop";
        "audio/3gpp2" = "mpv.desktop";
        "video/dv" = "mpv.desktop";
        "audio/dv" = "mpv.desktop";
        "audio/opus" = "mpv.desktop";
        "audio/vnd.dts" = "mpv.desktop";
        "audio/vnd.dts.hd" = "mpv.desktop";
        "audio/x-adpcm" = "mpv.desktop";
        "application/x-cue" = "mpv.desktop";
        "audio/m3u" = "mpv.desktop";
        "application/vnd.anki" = "anki.desktop";
        "application/vnd.ms-excel" = "wps-office-et.desktop";
        "application/x-excel" = "wps-office-et.desktop";
        "application/excel" = "wps-office-et.desktop";
        "application/x-msexcel" = "wps-office-et.desktop";
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "";
        "application/msword" = "wps-office-wps.desktop";
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "";
        "application/mspowerpoint" = "wps-office-wpp.desktop";
        "application/vnd.ms-powerpoint" = "wps-office-wpp.desktop";
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "wps-office-wpp.desktop";
        "application/vnd.oasis.opendocument.presentation" = "wps-office-wpp.desktop";
        "application/vnd.oasis.opendocument.spreadsheet" = "wps-office-et.desktop";
        "application/vnd.oasis.opendocument.text" = "wps-office-wps.desktop";
        "text/csv" = "wps-office-et.desktop";
      };
    };
  };

  /*
    xdg.configFile.pcmanfm = {
    target = "pcmanfm-qt/default/settings.conf";
    text = lib.generators.toINI { } {
      Behavior = {
        NoUsbTrash = true;
        SingleWindowMode = true;
      };
      System = {
        Archiver = "xarchiver";
        FallbackIconThemeName = iconTheme;
        Terminal = "${terminal}";
        SuCommand = "${lxqt-sudo} %s";
      };
      Thumbnail = { ShowThumbnails = true; };
      Volume = {
        AutoRun = false;
        CloseOnUnmount = true;
        MountOnStartup = false;
        MountRemovable = false;
      };
    };
    };
  */
}
