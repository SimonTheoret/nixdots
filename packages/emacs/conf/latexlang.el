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
(add-to-list 'auto-mode-alist '("\\.tex\\'" . LaTeX-mode))
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
(global-auto-revert-mode)

;; (add-to-list `TeX-command-list `("LaTeXMkServer"
;; 				 "latexmk -pvc -view=none %(latexmk-out) %(file-line-error) %(output-dir) %`%(extraopts) %S%(mode)%' %t"
;; 				 TeX-run-format nil (LaTeX-mode docTeX-mode)
;; 				 :help "Run LaTeXMk Continuously"))

(use-package cdlatex
  :hook
  (LaTeX-mode . cdlatex-mode)
  )


(use-package evil-tex
  ;; :defer t
  :hook (LaTeX-mode . evil-tex-mode))
