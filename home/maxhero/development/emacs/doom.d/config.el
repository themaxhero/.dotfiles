;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Marcelo A. de L. Santos"
      user-mail-address "contato.maxhero@gmail.com")

(setq tab-width 2)
(setq-default tab-width 2)


;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-monokai-pro)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(setq doom-font (font-spec :family "scientifica" :size 20 :weight 'light)
      doom-variable-pitch-font (font-spec :family "Roboto" :size 16)
      doom-big-font (font-spec :family "Roboto Mono" :size 36 :weight 'light))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(add-to-list 'auto-mode-alist '("\\.orgj\\'" . org-journal-mode))
(add-to-list 'initial-frame-alist '(maximized))
(after! org
  (use-package! org-journal-tags
   :after (org-journal)
   :config (org-journal-tags-autosync-mode))
  (setq org-journal-file-format "%Y%m%d.orgj")
  (setq org-agenda-files (list "~/org" "~/org/journal"))
  (setq org-agenda-file-regexp "\\`[^.].*\\.org\\|.todo\\'"))

(after! company
  (setq +lsp-company-backends '(company-tabnine :separate company-capf company-yasnippet))
  (setq company-show-numbers t)
  (setq company-idle-delay 0))

;; Workaround to enable running credo after lsp
(defvar-local my/flycheck-local-cache nil
(defun my/flycheck-checker-get (fn checker property)
  (or (alist-get property (alist-get checker my/flycheck-local-cache))
      (funcall fn checker property)))
(advice-add 'flycheck-checker-get :around 'my/flycheck-checker-get)
(add-hook 'lsp-managed-mode-hook
          (lambda ()
            (when (derived-mode-p 'elixir-mode)
              (setq my/flycheck-local-cache '((lsp . ((next-checkers . (elixir-credo)))))))
            ))

;; Configure elixir-lsp
;; replace t with nil to disable.
(setq lsp-elixir-fetch-deps t)
(setq lsp-elixir-suggest-specs t)
(setq lsp-elixir-signature-after-complete t)
(setq lsp-elixir-enable-test-lenses t)

;; Compile and test on save
(setq alchemist-hooks-test-on-save t)
(setq alchemist-hooks-compile-on-save t)

;; Disable popup quitting for Elixir’s REPL
;; Default behaviour of doom’s treating of Alchemist’s REPL window is to quit the
;; REPL when ESC or q is pressed (in normal mode). It’s quite annoying so below
;; code disables this and set’s the size of REPL’s window to 30% of editor frame’s
;; height.
(set-popup-rule! "^\\*Alchemist-IEx" :quit nil :size 0.3)

;; Do not select exunit-compilation window
(setq shackle-rules '(("*exunit-compilation*" :noselect t))
      shackle-default-rule '(:select t))

;; Set global LSP options
(after! lsp-mode (
        setq lsp-lens-enable t
        lsp-ui-peek-enable t
        lsp-ui-doc-enable nil
        lsp-ui-doc-position 'bottom
        lsp-ui-doc-max-height 70
        lsp-ui-doc-max-width 150
        lsp-ui-sideline-show-diagnostics t
        lsp-ui-sideline-show-hover nil
        lsp-ui-sideline-show-code-actions t
        lsp-ui-sideline-diagnostic-max-lines 20
        lsp-ui-sideline-ignore-duplicate t
        lsp-ui-sideline-enable t))

;; Enable folding
(setq lsp-enable-folding t)

;; Add origami and LSP integration
(use-package! lsp-origami)
(add-hook! 'lsp-after-open-hook #'lsp-origami-try-enable)
