;; -*- lexical-binding: t -*-
;; Package init

(setq straight-check-for-modifications '(check-on-save find-when-checking))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
;; Use-package magic!
(straight-use-package 'use-package)
(setq straight-vc-git-default-clone-depth '(1 single-branch))  ;; instead of the default 'full
(setq use-package-verbose t)

(use-package straight
  :custom
  (straight-use-package-by-default t))

(use-package gcmh
  :init
  (gcmh-mode 1))

;; General magic!
(use-package general
  :config
  (general-evil-setup t))
