;; -*- lexical-binding: t -*-

;; Tree-sitter for emacs

;; (defun tree-sitter-on ()
;;   "Turns on tree-sitter in all its glory"
;;   (turn-on-tree-sitter-mode)
;;   (tree-sitter-hl-mode))


;; ;; Tree-sitter
;; (use-package tree-sitter
;;   :hook
;;   (python-ts-mode . tree-sitter-on))
;;   :config
;;   (require 'tree-sitter-langs)

;; (use-package tree-sitter-langs
;;   :after tree-sitter)

;; (treesit-install-language-grammar 'rust)
;; (treesit-install-language-grammar 'go)
;; (treesit-install-language-grammar 'python)

(setq major-mode-remap-alist
      '((python-mode . python-ts-mode)
	(rust-mode . rustic-mode)
	(rust-ts-mode . rustic-mode)
	(go-mode . go-ts-mode)))

(defun set-font-level-ts (level)
  "Modify font lock level in Tree-sitter."
  (interactive "nEnter level: ")
  (setq treesit-font-lock-level level)
  (treesit-font-lock-recompute-features))

(defun set-python-colors ()
  (setq treesit-font-lock-feature-list
        '((comment definition)
          (keyword string type)
          (assignment
           builtin
           constant
           decorator
           escape-sequence
           number
           string-interpolation
           function)
          (bracket delimiter operator variable property)))
  (treesit-font-lock-recompute-features))

(defun set-rust-colors ()
  (setq treesit-font-lock-feature-list
	'((comment definition)
	  (keyword string)
	  (assignment attribute builtin constant escape-sequence number type function)
	  (bracket delimiter error operator property variable))
	)
  (treesit-font-lock-recompute-features))

(add-hook 'python-mode-hook #'set-python-colors)
(add-hook 'python-ts-mode-hook #'set-python-colors)

(add-hook 'rustic-mode-hook #'set-rust-colors)
(add-hook 'rustic-ts-mode-hook #'set-rust-colors)
