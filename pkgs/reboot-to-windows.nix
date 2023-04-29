{ pkgs, ... }:
pkgs.writeShellScriptBin "reboot-to-windows" ''
  ${pkgs.sudo}/bin/sudo ${pkgs.efibootmgr}/bin/efibootmgr --bootnext $(efibootmgr | grep Windows | sed 's/^.\{4\}//' | cut -c -4)
  reboot
''
