;; -*- lexical-binding: t -*-

(defun shell-other-window ()
  "Open a `shell' in a new window."
  (interactive)
  (let ((buf (shell)))
    (switch-to-buffer (other-buffer buf))
    (switch-to-buffer-other-window buf)))

(defun eshell-other-window ()
  "Open a `eshell' in a new window."
  (interactive)
  (let ((buf (eshell)))
    (switch-to-buffer (other-buffer buf))
    (switch-to-buffer-other-window buf)))

(defun eat-other-window ()
  "Open a `eat' in a new window."
  (interactive)
  (let ((buf (eat)))
    (switch-to-buffer (other-buffer buf))
    (switch-to-buffer-other-window buf)))

(use-package vterm
  :defer 1.5
  :init
  (setq vterm-always-compile-module t)
  :config
  (setq vterm-kill-buffer-on-exit t)
  (setq vterm-max-scrollback 10000)
  (setq vterm-timer-delay 0.01)
  )

;; This hack makes it possible to edit the current vterm command
;; without going to the end of the line
(add-hook 'evil-insert-state-entry-hook #'vterm-reset-cursor-point nil t)

;; Vterm toggle can often be annoyting
;; (use-package
;;   vterm-toggle
;;   :defer 1.5
;;   :after (vterm)
;;   :config
;;   (setq vterm-toggle-fullscreen-p nil)
;;   (add-to-list
;;    'display-buffer-alist
;;    '((lambda (buffer-or-name _)
;;        (let ((buffer (get-buffer buffer-or-name)))
;;          (with-current-buffer buffer
;;            (or (equal major-mode 'vterm-mode)
;;                (string-prefix-p
;; 		vterm-buffer-name (buffer-name buffer))))))
;;      (display-buffer-reuse-window display-buffer-at-bottom)
;;      ;;(display-buffer-reuse-window display-buffer-in-direction)
;;      ;;display-buffer-in-direction/direction/dedicated is added in emacs27
;;      ;;(direction . bottom)
;;      ;;(dedicated . t) ;dedicated is supported in emacs27
;;      (reusable-frames . visible) (window-height . 0.3))))

(use-package multi-vterm
  :defer 1.5
  :config
  (add-hook 'vterm-mode-hook
	    (lambda ()
	      (setq-local evil-insert-state-cursor 'box)
	      (evil-insert-state))))


(use-package eat
  :defer 1.5
  :straight (eat
	     :type git
	     :host codeberg
	     :repo "akib/emacs-eat"
	     :files ("*.el" ("term" "term/*.el") "*.texi"
		     "*.ti" ("terminfo/e" "terminfo/e/*")
		     ("terminfo/65" "terminfo/65/*")
		     ("integration" "integration/*")
		     (:exclude ".dir-locals.el" "*-tests.el")))
  )

(general-def
  :states 'normal
  :prefix "<leader> t"
  :prefix-command 'Term
  "t" '("Toggle vterm" . vterm)
  "T" '("Open vterm other window" . vterm-other-window)
  "b" '("Open terminal" . term)
  "e" '("Open eat" . eat)
  "E" '("Open eat other window" . eat-other-window)
  "a" '("Open ansi-term" . ansi-term)
  "s" '("Open shell" . shell)
  "S" '("Open shell other window" . shell-other-window)
  "n" '("Next vterm" . multi-vterm-next)
  "p" '("Previous vterm" . multi-vterm-prev)
  "c" '("Previous vterm" . multi-vterm)
  )
