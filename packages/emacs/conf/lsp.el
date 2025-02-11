;; -*- lexical-binding: t -*-

(use-package rust-mode)

;; NOTE: To make the language server functional, I symlinked
;; `language_server.sh` out of the directory, and into the `bin`
;; folder. This folder is on the `PATH` env. var.
(use-package elixir-mode
  :after (eglot)
  :hook
  (elixir-mode . eglot-ensure)
  (elixir-ts-mode . eglot-ensure)
  )

(use-package gleam-ts-mode
  :after (eglot projectile)
  :mode (rx ".gleam" eos)
  :config
  (add-to-list 'eglot-server-programs '(gleam-ts-mode . ("gleam" "lsp")))
  (add-to-list 'eglot-server-programs '(gleam-mode . ("gleam" "lsp")))
  (projectile-register-project-type 'gleam '("gleam.toml")
                                    :project-file "gleam.toml"
				    :compile "gleam build"
				    :test "gleam test"
				    :run "gleam run"
                                    :src-dir "src/"
                                    :test-dir "test/"
				    :test-suffix "_test")
  :hook
  (gleam-ts-mode . eglot-ensure)
  (gleam-mode . eglot-ensure)
  )

(use-package eglot
  :defer 1
  :straight (:type built-in)
  :config
  (add-hook 'rust-ts-mode-hook 'eglot-ensure)
  (add-hook 'python-ts-mode-hook 'eglot-ensure)
  (add-hook 'LaTeX-mode-hook 'eglot-ensure)
  (add-to-list 'eglot-stay-out-of 'flymake)
  ;; Disable inlay hints mode by default. Toggle to activate
  :hook
  ((eglot-managed-mode . manually-activate-flymake))
  :custom
  (eglot-autoshutdown t)  ;; shutdown language server after closing last file
  (eglot-confirm-server-initiated-edits nil)  ;; allow edits without confirmation
  )

;; Compromise between having no info and too much info
(setq eldoc-echo-area-use-multiline-p nil)

(use-package eglot-booster
  :straight (eglot-booster :type git
			   :host github
			   :repo "jdtsmith/eglot-booster"
			   )
  :after eglot
  :config
  (eglot-booster-mode)
  )

(use-package flymake
  :straight (:type built-in)
  :config
  :hook
  (eglot-mode . flymake-mode)
  ;; (add-hook 'eglot-mode-hook 'flymake-mode)
  )

(use-package flymake-clippy
  :hook (rust-mode . flymake-clippy-setup-backend))

(defun manually-activate-flymake ()
  (add-hook 'flymake-diagnostic-functions #'eglot-flymake-backend nil t)
  (flymake-mode 1))

(use-package flymake-diagnostic-at-point
  :after flymake
  :config
  (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode)
  (setq flymake-diagnostic-at-point-display-diagnostic-function #'flymake-diagnostic-at-point-display-minibuffer)
  )

(use-package consult-eglot
  :after (:all eglot consult))

(general-def
  :states
  'normal
  :prefix "<leader> c"
  :prefix-command 'Code
  "a"
  '("Execute action" . eglot-code-actions)
  "i"
  '("Find implementation" . eglot-find-implementation)
  "t"
  '("Find type def" . eglot-find-typeDefinition)
  "D"
  '("Find declaration" . eglot-find-declaration)
  "b"
  '("Open doc in buffer" . eldoc)
  "n"
  '("Rename" . eglot-rename)
  "f"
  '("Format buffer" .  apheleia-format-buffer)
  "m"
  '("Lsp Imenu" . imenu)
  "h"
  '("Hinlay hints" . eglot-inlay-hints-mode)
  "o"
  '("Casual Overlay" . casual-symbol-overlay-tmenu)
  "s"
  '("Consult search symbols" . consult-eglot-symbols)
  "j"
  '("Consult IMenu" . consult-imenu)
  "S"
  '("Eglot search symbols" . xref-find-apropos)
  )

(general-def
  :states
  'normal
  :prefix "<leader> c e"
  :prefix-command 'Errors
  "b"
  '("Flymake buffer" . flymake-show-buffer-diagnostics)
  "a"
  '("Flymake project" . flymake-show-project-diagnostics)
  )
