{ self, ... }@inputs:
pkgs:
let
  emacs-pkg = ((pkgs.emacsPackagesFor pkgs.emacs-git).emacsWithPackages (epkgs: [ epkgs.vterm ]));
in
{
    nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];

    environment.systemPackages = with pkgs; [
      ## Emacs itself
      binutils       # native-comp needs 'as', provided by this
      # 28.2 + native-comp
      emacs-pkg
      nil
      elixir-ls

      ## Doom dependencies
      git
      (ripgrep.override {withPCRE2 = true;})
      gnutls              # for TLS connectivity

      ## Optional dependencies
      fd                  # faster projectile indexing
      imagemagick         # for image-dired
      pinentry-emacs      # in-emacs gnupg prompts
      zstd                # for undo-fu-session/undo-tree compression
      clang-tools

      ## Module dependencies
      # :checkers spell
      (aspellWithDicts (ds: with ds; [ en en-computers en-science ]))
      # :tools editorconfig
      editorconfig-core-c # per-project style config
      # :tools lookup & :lang org +roam
      sqlite
      # :lang latex & :lang org (latex previews)
      texlive.combined.scheme-medium
      # :lang beancount
      beancount
      #unstable.fava  # HACK Momentarily broken on nixos-unstable
    ];

    environment = {
      extraInit = ''
        export PATH="/home/maxhero/.emacs.d/bin:${emacs-pkg}/emacs/bin:$PATH"
      '';
    };

    fonts.packages = [ pkgs.emacs-all-the-icons-fonts ];
  }
