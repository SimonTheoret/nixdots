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
  "<leader> f f"
  '("Find files" . ido-find-file)
  "<leader> f p"
  '("Search conf" . search-emacs-dir)
  "<leader> f d"
  '("Create dir" . make-directory)
  "<leader> f D"
  '("Delete directory" . delete-directory)
  "<leader> f r"
  '("Remove file" . delete-file)
  )
