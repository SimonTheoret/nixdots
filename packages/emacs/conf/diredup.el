;; -*- lexical-binding: t -*-


;; Makes dired goooood

(use-package diff-hl :config (global-diff-hl-mode))

(use-package diredfl :config (diredfl-global-mode))

(use-package
  dired-rsync
  :bind (:map dired-mode-map ("C-c C-r" . dired-rsync)))

(use-package
  dired-rsync-transient
  :bind
  (:map dired-mode-map ("C-c C-x" . dired-rsync-transient)))

;; (use-package dirvish)
;; (dirvish-override-dired-mode)


(defun search-emacs-dir ()
  (interactive)
  (ido-find-file-in-dir user-emacs-directory))

(general-def
  :states
  'normal
  :prefix "<leader> f"
  :prefix-command 'Files
  "f"
  '("Find files" . ido-find-file)
  "p"
  '("Search conf" . search-emacs-dir)
  "d"
  '("Create dir" . make-directory)
  "D"
  '("Delete directory" . delete-directory)
  "r f"
  '("Remove file" . delete-file)
  "c"
  '("Copy current file" . crux-copy-file-preserve-attributes)
  "r r"
  '("Rename current file" . crux-rename-file-and-buffer)
  )
