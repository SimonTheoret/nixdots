;; -*- lexical-binding: t -*-

(use-package tex
  :straight auctex
  :config
  ;; (setq-default TeX-master nil)
  (setq TeX-auto-save t
	TeX-parse-self t
	TeX-PDF-mode t
	TeX-electric-sub-and-superscript t
	TeX-view-program-selection '((output-pdf "PDF Tools"))
	TeX-source-correlate-start-server t
	TeX-source-correlate-method 'synctex
	TeX-source-correlate-mode t)
  :hook
  ( LaTeX-mode . visual-line-mode)
  ( LaTeX-mode . flyspell-mode)
  ( LaTeX-mode . LaTeX-math-mode)
  :general-config
  (general-def
    :states 'normal
    :keymaps 'LaTeX-mode-map
    :prefix "<localleader>"
    :prefix-command 'Local
    "m"
    '("Latex master" . TeX-command-master)
    )
  )
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
;; (use-package auctex-latexmk
;;   :after latex
;;   :init
;;   (setq auctex-latexmk-inherit-TeX-PDF-mode t)
;;   :hook
;;   (LaTeX-mode . (lambda () (setq TeX-command-default "LaTeXmk")))
;;   :config
;;   (auctex-latexmk-setup))

(use-package cdlatex
  :hook
  (LaTeX-mode . cdlatex-mode)
  (org-mode . org-cdlatex-mode))

;; (general-def
;;   :states 'normal
;;   :keymaps '(latex-mode-map)
;;   :prefix "<localleader>"
;;   :prefix-command 'Local
;;   )
