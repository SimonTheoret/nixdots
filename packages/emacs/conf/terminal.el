;; -*- lexical-binding: t -*-


(use-package vterm
  :config
  (setq vterm-kill-buffer-on-exit t))

(use-package
  vterm-toggle
  :config
  (setq vterm-toggle-fullscreen-p nil)
  (add-to-list
   'display-buffer-alist
   '((lambda (buffer-or-name _)
       (let ((buffer (get-buffer buffer-or-name)))
         (with-current-buffer buffer
           (or (equal major-mode 'vterm-mode)
               (string-prefix-p
		vterm-buffer-name (buffer-name buffer))))))
     (display-buffer-reuse-window display-buffer-at-bottom)
     ;;(display-buffer-reuse-window display-buffer-in-direction)
     ;;display-buffer-in-direction/direction/dedicated is added in emacs27
     ;;(direction . bottom)
     ;;(dedicated . t) ;dedicated is supported in emacs27
     (reusable-frames . visible) (window-height . 0.3))))

(general-def
  :states 'normal
  :prefix "<leader> t"
  :prefix-command 'Term
  "o" '("Open vterm other window" . vterm-other-window)
  "h" '("Open vterm here" . vterm)
  "t" '("Toggle vterm" . vterm-toggle)
  "b" '("Open terminal" . term))
