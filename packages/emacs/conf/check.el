;; -*- lexical-binding: t -*- 

(use-package flycheck
  :custom
  (flycheck-highlighting-mode nil) ;; remove highlighting
  :hook
  (lsp-mode . flycheck-mode)) 

(use-package consult-lsp
  :after lsp-mode)

(use-package flycheck-hl-todo
  :defer 5 ; Need to be initialized after the rest of checkers
  :straight (:host github :repo "alvarogonzalezsotillo/flycheck-hl-todo")
  :config
  (flycheck-hl-todo-setup))

(use-package hl-todo
  :init
  (global-hl-todo-mode))

(use-package consult-flycheck)

(general-def
  :states 'normal
  :prefix "<leader> c e"
  :prefix-command 'Errors
  "l" '("Search buffer errors" . consult-flycheck)
  "b" '("Buffer errors" . list-flycheck-errors)
  "s" '("Search workspace errors" . consult-lsp-diagnostics)
  "e" '("Workspace errors" . lsp-ui-flycheck-list)
  )

(general-def ;; Search keybindings
  :states 'normal
  :prefix "<leader> c s"
  :prefix-command 'SearchCode
    "i" '("Search symbols in workspace" . consult-lsp-symbols)
    "j" '("Search symbol in file" . consult-lsp-file-symbols)
  )
