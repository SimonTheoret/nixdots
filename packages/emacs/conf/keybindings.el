;; -*- lexical-binding: t -*- 

;; Keybindings

(use-package
  evil
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-overrifing-maps nil)
  (setq evil-want-C-u-scroll t)
  :config (evil-mode 1)

  (evil-set-leader
   '(normal visual replace operator motion emacs)
   (kbd "SPC")) ;; leader declaration
  (evil-set-leader 'normal (kbd "SPC m") t)) ;; Local leader declaration

(use-package evil-commentary :config (evil-commentary-mode))

(use-package
  evil-collection
  :after evil
  :config (evil-collection-init))

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

(use-package evil-easymotion :after evil)

(use-package
  evil-snipe
  :custom (evil-snipe-smart-case t)
  :config
  (evil-snipe-mode +1)
  (evil-snipe-override-mode +1))

;; org evil 
(use-package
  evil-org
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;; easy-motion for moving fast af
(use-package evil-easymotion
  :init
  (evilem-default-keybindings "<leader>"))

(use-package
  which-key
  :config (which-key-mode) (setq which-key-idle-delay 0.2))


(general-def
  :states
  'normal
  "<tab>"
  '("Jump pairs" . evil-jump-item)
  "TAB"
  '("Jump pairs" . evil-jump-item)
  "<leader> e b"
  '("eval buffer" . eval-buffer)
  "<leader> c c c"
  '("compile" . compile)
  "<leader> c c r"
  '("recompile" . recompile)
  "<leader> q c" 
  '("Close frame" . delete-frame)
  "<leader> q r" 
  '("Restart emacs" . restart-emacs)
  "<leader> q K" 
  '("Kill emacs" . save-buffers-kill-emacs)
  )

(general-def
  :states 'visual "<leader> e r" '("eval region" . eval-region))

;; Evil commands (:<yourcommandhere>)
;; :q should kill the current buffer rather than quitting emacs entirely
(evil-ex-define-cmd "q" 'kill-this-buffer)
;; Need to type out :quit to close emacs
(evil-ex-define-cmd "quit" 'evil-quit)


;; combine evil join and evil fill and move
;; (defun join-and-fill ()
;;   (evil-join))
