;; -*- lexical-binding: t -*- 

(defun utils-update-cm-emacs ()
  "Calls `chezmoi apply --force`"
  (interactive)
  (async-shell-command "chezmoi apply --force"))

;; (defun utils-create-directory (dirstr)
;;   "Create directory from current directory with a command from the
;; shell."
;;   (interactive
;;    (concat "sMake directory: " default-directory))
;;   ;; (shell-command (concat "mkdir" default-directory "/" str)
;;   (message "%s" (concat "mkdir" default-directory "/" dirstr)
;; 	   ))

(use-package crux
  :defer 3
  :general-config
  (general-def
    :states 'normal
    :prefix "<leader> o"
    :prefix-command 'Open
    "e" '("Open current file in external app" . crux-open-with)
    "u" '("View URL content" . crux-view-url)
    "c" '("Chezmoi apply overwrite" . utils-update-cm-emacs)
    ))
