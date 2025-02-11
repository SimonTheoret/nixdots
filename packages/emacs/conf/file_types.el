(use-package dockerfile-mode)
;; (use-package cmake-mode)
(use-package yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :general-config(
		  :states 'normal
		  :keymaps 'markdown-mode-map
		  :prefix "<localleader>"
		  :prefix-command 'Local
		  "c" '("Toggle checkbox" . markdown-toggle-gfm-checkbox)
		  )
  )
