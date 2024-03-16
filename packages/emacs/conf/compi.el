;; -*- lexical-binding: t -*- 


; Makes emacs write code in my place

;; Company Completion
(use-package company
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-minimum-prefix-length 1)
  (setq company-idlle-delay 0.2)
  :general-config
  (general-def company-active-map
   "<backtab>" (lambda () (interactive) (company-complete-common-or-cycle -1))
   "S-TAB" (lambda () (interactive) (company-complete-common-or-cycle -1))
   "<tab>" #'company-complete-common-or-cycle
   "TAB" #'company-complete-common-or-cycle
   "RET" #'newline
   "<return>" #'newline
   "C-<return>" #'company-complete))

;; (evil-global-set-key 'insert (kbd "TAB") 'company-select-next)
;; (evil-global-set-key 'insert (kbd "S-TAB") 'company-select-previous)
;; (evil-global-set-key 'insert (kbd "C-RET") 'company-complete-common))


;; (with-eval-after-load 'company
;;   (general-def (
;; 		:states 'insert
;; 		"<backtab>" (lambda () (interactive) (company-complete-common-or-cycle -1))
;; 		"<tab>" #'company-complete-common-or-cycle
;; 		       )))
;; (define-key company-active-map
;;             (kbd "<tab>")
;;             #'company-complete-common-or-cycle)
;; (define-key company-active-map
;;             (kbd "<backtab>")
;;             (lambda ()
;;               (interactive)
;;               (company-complete-common-or-cycle -1))))

(use-package company-quickhelp
  :after company
  :config
  (setq company-quickhelp-delay 0)
  :hook
  (company-mode . company-quickhelp-mode))

;; Snippets
(use-package yasnippet
  :init
  (yas-global-mode 1)
  :general
  (general-def :states 'normal  "<leader> i s" '("Insert snippet" . yas-insert-snippet)))
;; :config
;; (evil-global-set-key 'normal (kbd "<leader> i s") 'yas-insert-snippet))

(use-package doom-snippets
  :after yasnippet
  :straight (doom-snippets :type git :host github :repo "doomemacs/snippets" :files ("*.el" "*")))


