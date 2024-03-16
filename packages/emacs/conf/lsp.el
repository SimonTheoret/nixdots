;; -*- lexical-binding: t -*-

(defun dotfiles--lsp-deferred-if-supported ()
  "Run `lsp-deferred' if it's a supported mode."
  (unless (derived-mode-p 'emacs-lisp-mode)
    (lsp-deferred)))

(use-package
  lsp-mode
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  :hook
  ( ;; replace XXX-mode with concrete major-mode(e. g. python--tsmode)
   (python-ts-mode . lsp)
   ;; Do not add rust-ts-mode. Rustic starts automatically.
   (go-ts-mode . lsp)
   ;; if you want which-key integration
   (lsp-mode . lsp-enable-which-key-integration) (LaTeX-mode . lsp))
  :commands lsp
  :general-config
  (general-def
    :states
    'normal
    "<leader> c d"
    '("Find definition" . lsp-find-definition)
    "<leader> c a"
    '("Execute action" . lsp-execute-code-action)
    "<leader> c i"
    '("Find implementation" . lsp-find-implementation)
    "<leader> c t"
    '("Find type def" . lsp-find-type-definition)
    "<leader> c D"
    '("Find declaration" . lsp-find-declaration)
    "<leader> c k"
    '("Find declaration" . lsp-describe-thing-at-point)
    "<leader> c r f"
    '("Find reference" . lsp-ui-peek-find-references)
    "<leader> c r r"
    '("Rename" . lsp-rename)
    "<leader> c w r"
    '("LSP Workspace remove" . lsp-workspace-folders-remove)
    "<leader> c w a"
    '("LSP Workspace add" . lsp-workspace-folders-add)))

(with-eval-after-load 'lsp-mode
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-lens-enable t)
  (lsp-signature-mode t)
  ;; (lsp-ui-peek-enable)
  ;; (lsp-ui-doc-enable)
  (setq lsp-ui-doc-show-with-cursor t)
  (setq lsp-ui-doc-position 'bottom)
  ;; :global/:workspace/:file
  (setq lsp-modeline-diagnostics-scope :workspace))
;; :config
;; (setq lsp-modeline-diagnostics-enable t)
;; (setq lsp-modeline-diagnostics-scope :workspace))

(use-package all-the-icons)

;; optionally
;; By default, lsp-mode automatically activates lsp-ui unless lsp-auto-configure is set to nil.
(use-package lsp-ui :commands lsp-ui-mode)

;; LSP optimizations

(defun lsp-optim ()
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024)) ;; 1mb
  (setq lsp-use-plists t))

(add-hook 'lsp-mode-hook #'lsp-optim)

;; Python
(use-package
  lsp-pyright
  :after lsp-mode
  :init
  (setq lsp-pyright-diagnostic-mode "workspace")
  (setq lsp-pyright-multi-root nil)
  :hook
  (python-ts-mode
   .
   (lambda ()
     (require 'lsp-pyright)
     (lsp)))) ; or lsp-deferred


;; Rust
(use-package
  rustic
  :init
  (setq-default lsp-rust-analyzer-cargo-watch-command "clippy")
  :custom
  (rustic-analyzer-command '("rustup" "run" "stable" "rust-analyzer")))


;; Latex
<<<<<<< HEAD
(use-package
  lsp-latex
  :init (setq lsp-latex-forward-search-executable "zathura")
  (setq lsp-latex-forward-search-args
	'("--synctex-forward" "%l:1:%f" "%p"))
  :hook (tex-mode . lsp) (latex-mode . lsp) (LaTeX-mode . lsp))

;; Go
(use-package go-mode
  :config
  (setq-default lsp-go-use-gofumpt t))

(use-package go-guru
=======
(use-package lsp-latex
  :init
  (setq lsp-latex-forward-search-executable "zathura")
  (setq lsp-latex-forward-search-args '("--synctex-forward" "%l:1:%f" "%p"))
  :hook
  (go-mode . go-guru-hl-identifier-mode))

(use-package go-eldoc
  :hook
  (go-mode . go-eldoc-setup))

(use-package flycheck-golangci-lint
  :hook (go-mode . flycheck-golangci-lint-setup))

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-golangci-lint-setup))
