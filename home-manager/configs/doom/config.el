;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Michael Lingelbach"
      user-mail-address "m.j.lbach@gmail.com")

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

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Set org agenda files
(setq org-agenda-files (doom-files-in "~/org" :match "\\.org$" :depth 3))

;; Settings for hydra
(setq ivy-read-action-function #'ivy-hydra-read-action)

;; Get rid of smartparens
(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

;; Settings for mail
(setq mu4e-view-use-gnus t)

;; Use imagemagick for email
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; Set bindings for copy and paste
(global-set-key (kbd "C-S-c") #'clipboard-kill-ring-save)
(global-set-key (kbd "C-S-v") #'clipboard-yank)

;; Add langtool to emacs
(setq langtool-language-tool-server-jar "/nix/store/76h6kmnrksnxp1f9q8ivnkcxs5kqv6sp-LanguageTool-5.0/share/languagetool-server.jar")

;; Fix bug with emacs28 and latex
(when EMACS28+
  (add-hook 'latex-mode-hook #'TeX-latex-mode))

;; Set default pdflatex command to be latexmk to compile bibliograph
(setq pdf-latex-command "latexmk")

;; Don't override dumb terminal
(setq tramp-terminal-type "tramp")

;; Add remote path to tramp to acess local files
(after! tramp
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
  (add-to-list 'backup-directory-alist
               (cons "." "~/.emacs.d/backups/"))
  ;; (setq tramp-verbose 10)
  (customize-set-variable
   'tramp-backup-directory-alist backup-directory-alist)
  )

;; Fix native compilation in nix
(setq comp-async-env-modifier-form "")

;; Add pyright remote with ability to get remote virtualenv
(after! lsp-mode
  ;; (setq lsp-log-io t)
  (setq lsp-pyright-use-library-code-for-types t)
  (setq lsp-pyright-diagnostic-mode "workspace")
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-tramp-connection (lambda ()
                                            (cons "pyright-langserver"
                                                  lsp-pyright-langserver-command-args)))
    :major-modes '(python-mode)
    :remote? t
    :server-id 'pyright-remote
    :multi-root t
    :priority 3
    :initialization-options (lambda () (let* ((pyright_hash (lsp-configuration-section "pyright"))
                                              (python_hash (lsp-configuration-section "python"))
                                              (_ (puthash "pythonPath" (concat (replace-regexp-in-string (file-remote-p default-directory) "" pyvenv-virtual-env) "bin/python") (gethash "python" python_hash))))
                                         (ht-merge pyright_hash
                                                   python_hash)))
    :initialized-fn (lambda (workspace)
                      (with-lsp-workspace workspace
                                          (lsp--set-configuration
                                           (let* ((pyright_hash (lsp-configuration-section "pyright"))
                                                  (python_hash (lsp-configuration-section "python"))
                                                  (_ (puthash "pythonPath" (concat (replace-regexp-in-string (file-remote-p default-directory) "" pyvenv-virtual-env) "bin/python") (gethash "python" python_hash))))
                                             (ht-merge pyright_hash
                                                       python_hash)))))
    :download-server-fn (lambda (_client callback error-callback _update?)
                          (lsp-package-ensure 'pyright callback error-callback))
    :notification-handlers (lsp-ht ("pyright/beginProgress" 'lsp-pyright--begin-progress-callback)
                                   ("pyright/reportProgress" 'lsp-pyright--report-progress-callback)
                                   ("pyright/endProgress" 'lsp-pyright--end-progress-callback))))
  )

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
