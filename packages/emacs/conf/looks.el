;; -*- lexical-binding: t -*- 


;; Makes emacs good looking

;; Smooth scrolling
(use-package smooth-scrolling
  :init
  (smooth-scrolling-mode 1))

;; Theme
(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-molokai-sick t)

  ;; Enable flashing mode-line on errors
  ;; (doom-themes-visual-bell-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; (use-package all-the-icons
;;   :if (display-graphic-p))

;; (use-package all-the-icons-completion
;;   :init
;;   (all-the-icons-completion-mode)
;;   (add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup))

;; (use-package all-the-icons-dired
;;   :after all-the-icons
;;   (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

(use-package nerd-icons)
(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))


;; THe essential modeline
(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

;; Noice splash screen
(use-package dashboard
  :after nerd-icons
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  (setq dashboard-display-icons-p t) ;; display icons on both GUI and terminal
  (setq dashboard-icon-type 'nerd-icons) ;; use `nerd-icons' package
  (setq dashboard-startup-banner (concat user-emacs-directory "true.png"))
  (setq dashboard-center-content t)
  (setq dashboard-set-init-info t)
  )


;; cute aestethic plugin
(use-package solaire-mode
  :init
  (solaire-global-mode +1))

(use-package rainbow-delimiters
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))


(use-package ligature
  :config
  (ligature-set-ligatures 'prog-mode '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\" "{-" "::"
                                       ":::" ":=" "!!" "!=" "!==" "-}" "----" "-->" "->" "->>"
                                       "-<" "-<<" "-~" "#{" "#[" "##" "###" "####" "#(" "#?" "#_"
                                       "#_(" ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*" "/**"
                                       "/=" "/==" "/>" "//" "///" "&&" "||" "||=" "|=" "|>" "^=" "$>"
                                       "++" "+++" "+>" "=:=" "==" "===" "==>" "=>" "=>>" "<="
                                       "=<<" "=/=" ">-" ">=" ">=>" ">>" ">>-" ">>=" ">>>" "<*"
                                       "<*>" "<|" "<|>" "<$" "<$>" "<!--" "<-" "<--" "<->" "<+"
                                       "<+>" "<=" "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<"
                                       "<~" "<~~" "</" "</>" "~@" "~-" "~>" "~~" "~~>" "%%"))
  
  (global-ligature-mode 't))

