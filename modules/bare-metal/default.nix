{ pkgs, config, ... }: {
  # Better voltage and temperature
  boot.extraModulePackages = with config.boot.kernelPackages; [ zenpower ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  # Use Systemd Boot
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  hardware.bluetooth.enable = true;
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ rocm-opencl-icd rocm-opencl-runtime ];
  };

  programs.nm-applet.enable = true;
  programs.waybar.enable = true;
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      swaylock
      swayidle
      swaynotificationcenter
      wl-clipboard
      libinput
      libinput-gestures
      wofi
    ];
    extraSessionCommands = ''
      # Force wayland overall.
      export CLUTTER_BACKEND='wayland'
      export ECORE_EVAS_ENGINE='wayland_egl'
      export ELM_ENGINE='wayland_egl'
      export GDK_BACKEND='wayland'
      export MOZ_ENABLE_WAYLAND=1
      export QT_AUTO_SCREEN_SCALE_FACTOR=0
      export QT_QPA_PLATFORM='wayland-egl'
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export SAL_USE_VCLPLUGIN='gtk3'
      export SDL_VIDEODRIVER='wayland'
      export _JAVA_AWT_WM_NONREPARENTING=1
      export NIXOS_OZONE_WL=1

      # KDE/Plasma platform for Qt apps.
      export QT_QPA_PLATFORMTHEME='kde'
      export QT_PLATFORM_PLUGIN='kde'
      export QT_PLATFORMTHEME='kde'

      export GTK_IM_MODULE='ibus'
      export QT_IM_MODULE='ibus'
      export XMODIFIERS='@im=ibus'
      export GTK_IM_MODULE='/run/current-system/sw/lib/gtk-2.0/2.10.0/immodules/im-ibus.so'
    '';
  };

  xdg.portal = {
    wlr.enable = true;
    extraPortals = with pkgs;
      [
        #xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
  };
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.package = pkgs.i3-gaps;
  systemd.targets."i3-session" = {
    enable = true;
    description = "i3 session";
    bindsTo = [
      "graphical-session.target"
    ];
  };
  services.udisks2.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  sound.mediaKeys.enable = true;
  services.blueman.enable = true;
  services.flatpak.enable = true;
  services.minidlna = {
    enable = true;
    settings.media_dirs = [ "/home/upnp-shared/Media" ];
  };
  services.acpid.enable = true;
  services.aria2.enable = true;
  services.fwupd.enable = true;
  services.ntp.enable = true;
  services.tumbler.enable = true;
}
