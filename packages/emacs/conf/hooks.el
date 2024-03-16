;; -*- lexical-binding: t -*- 


;; Nice Hooks bro



(defun activate-word-wrap ()
  "Activate word wrap"
  (setq word-wrap t))

(defun deactivate-word-wrap ()
  (setq word-wrap nil))

(add-hook 'prog-mode-hook 'deactivate-word-wrap)
(add-hook 'org-mode-hook 'deactivate-word-wrap)

