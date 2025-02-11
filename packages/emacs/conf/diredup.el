;; -*- lexical-binding: t -*-


;; Makes dired goooood

(setq dired-listing-switches "-alh")

(use-package diredfl :config (diredfl-global-mode))

(use-package
  dired-rsync
  :bind (:map dired-mode-map ("<leader> r r" . dired-rsync)))

(use-package
  dired-rsync-transient
  :bind
  (:map dired-mode-map ("<leader> r t" . dired-rsync-transient)))


(use-package async
  :init
  (dired-async-mode 1))

(defun search-emacs-dir ()
  (interactive)
  (ido-find-file-in-dir "~/.local/share/chezmoi/dot_config/emacs/" ))

(defun search-emacs-dir-other-window ()
  (interactive)
  (ido-file-internal 'other-window 'find-file-other-window  "~/.local/share/chezmoi/dot_config/emacs/" ))

(defun search-chezmoi-dir ()
  (interactive)
  (ido-find-file-in-dir "~/.local/share/chezmoi" ))

(defun search-chezmoi-dir-other-window ()
  (interactive)
  (ido-file-internal 'other-window 'find-file-other-window  "~/.local/share/chezmoi" ))

(defun search-home-dir ()
  (interactive)
  (ido-find-file-in-dir "~/" ))

(defun search-home-dir-other-window ()
  (interactive)
  (ido-file-internal 'other-window 'find-file-other-window "~/" ))

(add-hook 'dired-mode-hook (lambda () (setq display-line-numbers 'relative)))

(general-def
  :states
  'normal
  :prefix "<leader> f"
  :prefix-command 'Files
  "f"
  '("Find files" . ido-find-file)
  "F"
  '("Find files other window" . ido-find-file-other-window)
  "p"
  '("Search conf" . search-emacs-dir)
  "P"
  '("Search conf other window" . search-emacs-dir-other-window)
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
  "o"
  '("Dired here" . dired-jump)
  "O"
  '("Dired here other window" . dired-jump-other-window)
  "l"
  '("Chezmoi files" . search-chezmoi-dir)
  "L"
  '("Chezmoi files other window" . search-chezmoi-dir-other-window)
  "h"
  '("Home files" . search-home-dir)
  "H"
  '("Home files other window" . search-home-dir-other-window)
  )



(general-def
  :states
  'normal
  :prefix "<leader> f m"
  :prefix-command 'Modify
  "n"
  '("Rename current file" . crux-rename-file-and-buffer)
  "d"
  '("Remove file" . delete-file)
  )
