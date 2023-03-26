{ gtkTheme, iconTheme, gtk2-rc-files, ... }:
''
  export GTK_THEME='${gtkTheme}'
  export GTK_ICON_THEME='${iconTheme}'
  export GTK2_RC_FILES='${gtk2-rc-files}'
  export QT_STYLE_OVERRIDE='gtk2'

  # KDE/Plasma platform for Qt apps.
  export QT_QPA_PLATFORMTHEME='kde'
  export QT_PLATFORM_PLUGIN='kde'
  export QT_PLATFORMTHEME='kde'
'';
