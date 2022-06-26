{ nur, lib, ... }:
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
}
