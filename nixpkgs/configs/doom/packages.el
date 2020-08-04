;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;; (use-package! lsp-python-ms
;;   :init (setq lsp-python-ms-nupkg-channel "beta")
;;   :after lsp-mode)
;;; Examples:
;; (package! some-package)

;; Use my local fork of poetry with support for TRAMP
(package! poetry :recipe (:local-repo "/home/michael/Repositories/emacs_packages/poetry.el"))

;; Programming environment
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)
