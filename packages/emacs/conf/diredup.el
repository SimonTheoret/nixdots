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
  "c"
  '("Copy current file" . crux-copy-file-preserve-attributes)
  "e"
  '("sudoedit current file" . crux-sudo-edit)
  "n"
  '("Create empty file" . dired-create-empty-file)
  "b"
  '("Fuzzy search files" . consult-fd)
  "g"
  '("Change current dir" . cd)
  )

(general-def
  :states
  'normal
  :prefix "<leader> f r"
  :prefix-command 'Modify
  "r"
  '("Rename current file" . crux-rename-file-and-buffer)
  "f"
  '("Remove file" . delete-file)
  )
