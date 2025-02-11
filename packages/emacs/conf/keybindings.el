;; -*- lexical-binding: t -*-

;; Keybindings

(use-package
  evil
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-overrifing-maps nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-minibuffer t)
  :config (evil-mode 1)

  (evil-set-leader
   '(normal visual replace operator motion emacs)
   (kbd "SPC")) ;; leader declaration
  (evil-set-leader 'normal (kbd "SPC m") t) ;; Local leader declaration
  :bind (
	 :map evil-insert-state-map
	 ("<down-mouse-1>" . nil)
	 ("<mouse-1>" . nil)
	 ("<down-mouse-3>" . nil)
	 ("<mouse-3>" . nil)
	 :map evil-normal-state-map
	 ("<down-mouse-1>" . nil)
	 ("<mouse-1>" . nil)
	 ("<down-mouse-3>" . nil)
	 ("<mouse-3>" . nil)
	 :map    evil-motion-state-map
	 ("<down-mouse-1>" . nil)
	 ("<mouse-1>" . nil)
	 ("<down-mouse-3>" . nil)
	 ("<mouse-3>" . nil)
	 ))

(use-package evil-commentary :config (evil-commentary-mode))

;; evil-collection-setup-minibuffer must be set BEFORE loading evil-collection
(setq-default evil-collection-setup-minibuffer t )
(use-package
  evil-collection
  :after evil
  :init (evil-collection-init)
  ;; :custom (evil-collection-setup-minibuffer t)
  )

(use-package
  evil-surround
  :after evil
  :config (global-evil-surround-mode 1))

(use-package
  evil-args
  :after evil
  :general-config
  (:states
   'normal
   "L"
   '("Next arg" . evil-forward-arg)
   "H"
   '("Previous arg" . evil-backward-arg))
  (:states
   'motion
   "L"
   '("Next arg" . evil-forward-arg)
   "H"
   '("Previous arg" . evil-backward-arg)))

(use-package evil-traces
  :config
  (evil-traces-use-diff-faces) ; if you want to use diff's faces
  (evil-traces-mode))

(use-package evil-goggles
  :config
  (evil-goggles-mode)

  ;; optionally use diff-mode's faces; as a result, deleted text
  ;; will be highlighed with `diff-removed` face which is typically
  ;; some red color (as defined by the color theme)
  ;; other faces such as `diff-added` will be used for other actions
  (evil-goggles-use-diff-faces)
  (setq evil-goggles-duration 0.050) ;; default is 0.200
  )

(use-package evil-easymotion :after evil)


(use-package
  evil-snipe
  :custom (evil-snipe-smart-case t)
  :config
  (evil-snipe-mode +1)
  (evil-snipe-override-mode +1))

;; easy-motion for moving fast af
(use-package evil-easymotion
  :init
  (evilem-default-keybindings "<leader>"))

(use-package
  which-key
  :config (which-key-mode) (setq which-key-idle-delay 0.1))

(use-package expreg)


(use-package evil-mc
  :init
  (global-evil-mc-mode 1))

(general-def
  :states
  'normal
  "<leader> w"
  '("Jump to word" . avy-goto-word-1)
  )
(general-def
  :states
  'normal
  :prefix "<leader> e"
  :prefix-command 'Eval
  "b"
  '("eval buffer" . eval-buffer)
  )
(general-def
  :states
  'visual
  :prefix "<leader> e"
  :prefix-command 'Eval
  "r"
  '("eval region" . eval-region))

(general-def
  :states
  'normal
  :prefix "<leader> q"
  :prefix-command 'Quit
  "c"
  '("Close frame" . delete-frame)
  "r"
  '("Restart emacs" . restart-emacs)
  "K"
  '("Kill emacs" . save-buffers-kill-emacs)
  )

(general-def
  :states
  'normal
  "TAB"
  '("Jump pairs" . evil-jump-item)
  )

;; (general-def
;;   :states 'visual "<leader> e r" '("eval region" . eval-region))

;; Evil commands (:<yourcommandhere>)
;; :q should kill the current buffer rather than quitting emacs entirely
(evil-ex-define-cmd "q" 'kill-this-buffer)
;; Need to type out :quit to close emacs
(evil-ex-define-cmd "quit" 'evil-quit)

(general-def
  :states 'normal
  :prefix "<leader> r"
  :prefix-command 'Region
  "e"
  '("Expand region" . expreg-expand)
  "c"
  '("Contract region" . expreg-contract)
  "b"
  '("Revert buffer" . revert-buffer-fontify)
  )

;; (general-def
;;   :states
;;   :prefix "<leader> m"
;;   :prefix-command 'Local
;;   )

;; combine evil join and evil fill and move
;; (defun join-and-fill ()
;;   (evil-join))
(with-eval-after-load 'dired
  (evil-collection-define-key 'normal 'dired-mode-map " " nil))
(global-unset-key (kbd "M-SPC") )


(use-package casual-avy)

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
					 (car next-win-edges))
				     (<= (cadr this-win-edges)
					 (cadr next-win-edges)))))
             (splitter
	      (if (= (car this-win-edges)
		     (car (window-edges (next-window))))
		  'split-window-horizontally
		'split-window-vertically)))
	(delete-other-windows)
	(let ((first-win (selected-window)))
	  (funcall splitter)
	  (if this-win-2nd (other-window 1))
	  (set-window-buffer (selected-window) this-win-buffer)
	  (set-window-buffer (next-window) next-win-buffer)
	  (select-window first-win)
	  (if this-win-2nd (other-window 1))))))

(evil-global-set-key 'normal (kbd "C-w R") 'toggle-window-split)
(evil-global-set-key 'insert (kbd "C-c p") 'evil-paste-after)
(evil-global-set-key 'insert (kbd "C-c P") 'evil-paste-before)
(evil-global-set-key 'normal (kbd "C-c i") 'next-buffer)
(evil-global-set-key 'normal (kbd "C-c o") 'previous-buffer)
