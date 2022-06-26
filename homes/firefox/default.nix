{ nur, lib, ... }:
{
  import = (lib.attrValues nur.repos.moredhel.hmModules.modules);
  programs.firefox = {
    enable = true;
    profiles = {
      "tlb" = {
        id = 1;
        name = "tlb";
        isDefault = false;
        extensions = with nur.repos.rycee.firefox-addons; [
          bitwarden
          1
          password-onepassword-password-manager
        ];
      };
      "dea" = {
        id = 2;
        name = "dea";
        isDefault = false;
        extensions = with nur.repos.rycee.firefox-addons; [
          bitwarden
        ];
      };
      "p" = {
        id = 0;
        name = "p";
        isDefault = true;
        extensions = with nur.repos.rycee.firefox-addons; [
          bitwarden
        ];
      };
    };
  };
}
