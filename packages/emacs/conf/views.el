;; -*- lexical-binding: t -*-

;; Managing perspectives/views


;; perspective
;; (use-package
;;   perspective
;;   :custom
;;   (persp-mode-prefix-key (kbd "<leader> <tab>")) ; pick your own prefix key here
;;   :init (persp-mode))

;; persp-mode
(use-package
  persp-mode
  :custom
  (persp-keymap-prefix (kbd "<leader> TAB"))
  (persp-auto-save-opt 0)
  (persp-auto-resume-time -1)
  (persp-nil-name "main")
  :init
  (persp-mode)
  (setq-default persp-nil-name "main"))

(with-eval-after-load "persp-mode-autoloads"
  (setq persp-autokill-buffer-on-remove 'kill-weak))


;; (use-package persp-projectile
;;   :after (perspective)
;;   )

;; (defun views--desktop-mode-setup ()
;;   (desktop-save-mode 1)
;;   (setq history-length 100)
;;   (add-to-list 'desktop-globals-to-save 'file-name-history)
;;   (clean-buffer-list))

;; (views--desktop-mode-setup)

;; Not Needed. It is in the bottom right corner
;; (use-package perspective-tabs
;;   :after (perspective)
;;   :straight (:host sourcehut :repo "woozong/perspective-tabs")
;;   :init
;;   (perspective-tabs-mode +1))
