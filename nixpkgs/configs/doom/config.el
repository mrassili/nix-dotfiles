;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Michael Lingelbach"
      user-mail-address "m.j.lbach@gmail.com")

;; Settings for hydra
(setq ivy-read-action-function #'ivy-hydra-read-action)

(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

;; Settings for mail
(setq mu4e-view-use-gnus t)

(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; Set bindings for copy and paste
(global-set-key (kbd "C-S-c") #'clipboard-kill-ring-save)
(global-set-key (kbd "C-S-v") #'clipboard-yank)

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
(setq doom-font (font-spec :family "Meslo LGS NF" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-agenda-files (doom-files-in "~/org" :match "\\.org$" :depth 3))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Don't override dumb terminal
(setq tramp-terminal-type "tramp")

(after! tramp (add-to-list 'tramp-remote-path 'tramp-own-remote-path))

(after! lsp-python-ms
  (setq lsp-python-ms-executable (executable-find "python-language-server"))
  (set-lsp-priority! 'mspyls 1))


(after! lsp-mode
  (lsp-register-client
    (make-lsp-client :new-connection (lsp-tramp-connection "python-language-server")
                      :major-modes '(python-mode)
                      :remote? t
                      :notification-handlers (lsp-ht ("python/languageServerStarted" 'lsp-python-ms--language-server-started-callback)
                                                    ("telemetry/event" 'ignore)
                                                    ("python/reportProgress" 'lsp-python-ms--report-progress-callback)
                                                    ("python/beginProgress" 'lsp-python-ms--begin-progress-callback)
                                                    ("python/endProgress" 'lsp-python-ms--end-progress-callback))
                      :initialization-options 'lsp-python-ms--extra-init-params
                      :initialized-fn (lambda (workspace)
                                        (with-lsp-workspace workspace
                                          (lsp--set-configuration (lsp-configuration-section "python"))))
                      :server-id 'pyls-remote)))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;

;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; (use-package! org-gcal
;;   :after org
;;   :config
;;   (setq org-gcal-client-id "your-id-foo.apps.googleusercontent.com"
;;         org-gcal-client-secret "your-secret"
;;         org-gcal-file-alist '(("your-mail@gmail.com" .  "~/schedule.org")
;;                               ("another-mail@gmail.com" .  "~/task.org"))))

