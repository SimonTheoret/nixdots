;; -*- lexical-binding: t -*- 

(use-package flycheck
  :custom
  (flycheck-highlighting-mode nil)
  :hook
  (lsp-mode . flycheck-mode)) 

(use-package consult-lsp
  :after lsp-mode
  :general
  (general-def
    'normal
    "<leader> c l" '("List diagnostics" . consult-lsp-diagnostics)
    "<leader> c s i" '("Search symbols in workspace" . consult-lsp-symbols)
    "<leader> c s j" '("Search symbol in file" . consult-lsp-file-symbols)
    ))

(use-package flycheck-hl-todo
  :defer 5 ; Need to be initialized after the rest of checkers
  :straight (:host github :repo "alvarogonzalezsotillo/flycheck-hl-todo")
  :config
  (flycheck-hl-todo-setup))

(use-package hl-todo
  :init
  (global-hl-todo-mode))

