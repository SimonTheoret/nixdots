;; -*- lexical-binding: t -*-

;; Pdf tools
(use-package pdf-tools
  :defer 1
  :init (setq pdf-view-use-unicode-ligther nil)
  :config
  (pdf-tools-install)
  (setq auto-revert-interval 0.5)
  )

