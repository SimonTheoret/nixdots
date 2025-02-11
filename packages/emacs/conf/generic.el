;; -*- lexical-binding: t -*-


;; Generic goodies

(setq inhibit-startup-message t)

;; Turn off some unneeded UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; font
;; (set-frame-font "JetBrainsMono Nerd Font Mono 100" nil t)


;; Laptop
(if (and (string= "simon" (system-name)) (string= "gnu/linux" system-type))
    (add-to-list 'default-frame-alist '(font . "JetBrainsMonoNL Nerd Font Mono-14")))
;; Desktop
(if (and (string= "Simon-Ubuntu-24" (system-name)) (string= "gnu/linux" system-type))
    (add-to-list 'default-frame-alist '(font . "JetBrainsMonoNL Nerd Font Mono-13")))
;; Serveur druide
(if (and (string= "stheoret" (system-name)) (string= "gnu/linux" system-type))
    (add-to-list 'default-frame-alist '(font . "JetBrainsMonoNL Nerd Font Mono-13")))
;; MacOS Druide
(if (and (string= "stheoret" (system-name)) (string= "darwin" system-type))
    (add-to-list 'default-frame-alist '(font . "JetBrainsMonoNL Nerd Font Mono-14")))

;; Scrolling
(pixel-scroll-mode 1)
(setq scroll-step 1)
(setq scroll-conservatively 10000)


(setq blink-cursor-mode t)
;; (setq scroll-step 1) ;; keyboard scroll one line at a time

;; Display relative line numbers in every buffer
;; (global-display-line-numbers-mode nil)
;; (setq display-line-numbers-type 'relative)

;; Electric defaults
(electric-pair-mode t)
(electric-indent-mode t)

;; Nice greek symbols
(global-prettify-symbols-mode)

(add-hook
 'prog-mode-hook
 (lambda ()
   (push '(">=" . ?\u2265) prettify-symbols-alist)
   (push '("<=" . ?\u2264) prettify-symbols-alist)
   (push '("!=" . ?\u2260) prettify-symbols-alist)
   (push '("==" . ?\u2A75) prettify-symbols-alist)
   (push '("=~" . ?\u2245) prettify-symbols-alist)
   (push '("<-" . ?\u2190) prettify-symbols-alist)
   (push '("->" . ?\u2192) prettify-symbols-alist)
   (push '("<-" . ?\u2190) prettify-symbols-alist)
   (push '("|>" . ?\u25B7) prettify-symbols-alist)))

(setq confirm-kill-emacs #'yes-or-no-p)

;; The variable redisplay-dont-pause, when set to t, will cause Emacs
;; to fully redraw the display before it processes queued input
;; events. This may have slight performance implications if you’re
;; aggressively mouse scrolling a document or rely on your keyboard’s
;; auto repeat feature. For most of us, myself included, it’s probably
;; a no-brainer to switch it on.
(setq redisplay-dont-pause nil)

(add-hook 'text-mode-hook #'auto-fill-mode)

;; create the autosave dir if necessary, since emacs won't.
(make-directory (format "%sbackups" user-emacs-directory) t)

(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))

(setq auto-save-file-name-transforms
      `((".*" ,(format "%sbackups" user-emacs-directory) t)))

(defun revert-buffer-fontify()
  (interactive)
  (revert-buffer)
  (font-lock-debug-fontify)
  (hl-todo-mode)
  )
