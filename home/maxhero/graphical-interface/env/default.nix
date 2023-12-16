{ pkgs, ... }:
let
  gtkTheme = "Orchis-Dark";
  iconTheme = "Tela-circle-dark";
  gtk2-rc-files = "${pkgs.orchis-theme}/share/themes/${gtkTheme}/gtk-2.0/gtkrc";
in
rec {
  wayland_env = [
    { name = "BEMENU_BACKEND"; value = "wayland"; }
    { name = "CLUTTER_BACKEND"; value = "wayland"; }
    { name = "ECORE_EVAS_ENGINE"; value = "wayland_egl"; }
    { name = "ELM_ENGINE"; value = "wayland_egl"; }
    { name = "GDK_BACKEND"; value = "wayland"; }
    { name = "SDL_VIDEODRIVER"; value = "wayland"; }
    { name = "QT_QPA_PLATFORM"; value = "wayland-egl"; }
    { name = "MOZ_ENABLE_WAYLAND"; value = "1"; }
    { name = "NIXOS_OZONE_WL"; value = "1"; }
    { name = "QT_WAYLAND_DISABLE_WINDOWDECORATION"; value = "1"; }
  ];

  hyprland_env = wayland_env ++ qt_fixes ++ general_env ++ [
    { name = "XDG_CURRENT_DESKTOP"; value = "Hyprland"; }
    { name = "XCURSOR_SIZE"; value = "24"; }
  ];

  sway_env = wayland_env ++ general_env;

  bash_env = general_env;

  qt_fixes = [
    # KDE/Plasma platform for Qt apps."
    { name = "QT_QPA_PLATFORMTHEME"; value = "kde"; }
    { name = "QT_PLATFORM_PLUGIN"; value = "kde"; }
    { name = "QT_PLATFORMTHEME"; value = "kde"; }
    { name = "QT_AUTO_SCREEN_SCALE_FACTOR"; value = "0"; }
  ];

  general_env = qt_fixes ++ [
    { name = "SAL_USE_VCLPLUGIN"; value = "gtk3"; }
    { name = "_JAVA_AWT_WM_NONREPARENTING"; value = "1"; }
    { name = "GTK_THEME"; value = "${gtkTheme}"; }
    { name = "GTK_ICON_THEME"; value = "${iconTheme}"; }
    { name = "GTK2_RC_FILES"; value = "${gtk2-rc-files}"; }
    { name = "QT_STYLE_OVERRIDE"; value = "gtk2"; }
  ];

  xorg_env = [ ];
}
