{ pkgs, ... }:
pkgs.writeShellScriptBin "reboot-to-windows" ''
  ${pkgs.sudo}/bin/sudo ${pkgs.efibootmgr}/bin/efibootmgr --bootnext $(${pkgs.efibootmgr}/bin/efibootmgr | ${pkgs.gnugrep}/bin/grep Windows | ${pkgs.gnused}/bin/sed 's/^.\{4\}//' | ${pkgs.coreutils}/bin/cut -c -4)
  reboot
''
