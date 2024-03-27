;; -*- lexical-binding: t -*- 


;; Generic goodies

(setq inhibit-startup-message t)

;; Turn off some unneeded UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; font
;; (set-frame-font "JetBrainsMono Nerd Font Mono 100" nil t)
(if (string= "laptop" (system-name))
    (add-to-list 'default-frame-alist '(font . "JetBrainsMonoNL Nerd Font Mono-9"))
  (add-to-list 'default-frame-alist '(font . "JetBrainsMonoNL Nerd Font Mono-11")))

;; (add-to-list 'default-frame-alist '(font . "FiraCode Nerd Font-11"))

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

(setq confirm-kill-emacs #'yes-or-no-p)

;; The variable redisplay-dont-pause, when set to t, will cause Emacs
;; to fully redraw the display before it processes queued input
;; events. This may have slight performance implications if you’re
;; aggressively mouse scrolling a document or rely on your keyboard’s
;; auto repeat feature. For most of us, myself included, it’s probably
;; a no-brainer to switch it on.
(setq redisplay-dont-pause t)

;; elimiate 'file~'
(setq make-backup-files nil)
(add-hook 'text-mode-hook #'auto-fill-mode)

(use-package gcmh
  :config
  (gcmh-mode 1))
