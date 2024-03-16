;; -*- lexical-binding: t -*- 

(use-package tex
  :straight auctex
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (setq TeX-PDF-mode t)
  (setq TeX-electric-sub-and-superscript t)
  :hook
  ( LaTeX-mode . visual-line-mode)
  ( LaTeX-mode . flyspell-mode)
  ( LaTeX-mode . LaTeX-math-mode)
  ;; () 
  )

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
