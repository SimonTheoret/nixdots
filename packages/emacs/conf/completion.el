;; -*- lexical-binding: t -*-

;; Makes emacs write code in my place

;; ;; Company Completion
(use-package company
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-minimum-prefix-length 2)
  (setq company-idle-delay 0.15)
  (setq company-backends '((company-capf  company-files company-keywords :with company-yasnippet)))
  :general-config
  (general-def company-active-map
    "<backtab>" (lambda () (interactive) (company-complete-common-or-cycle -1))
    "S-TAB" (lambda () (interactive) (company-complete-common-or-cycle -1))
    "TAB" #'company-complete-common-or-cycle
    "<tab>" #'company-complete-common-or-cycle
    "RET" #'newline
    "<return>" #'newline
    "C-<return>" #'company-complete-selection
    "C-<RET>" #'company-complete-selection
    "C-b" #'company-complete-selection
    ))
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
  (setq company-quickhelp-delay 1)
  :hook
  (company-mode . company-quickhelp-mode))

;; Snippets
(use-package yasnippet
  :init
  (yas-global-mode 1)
  :general
  (general-def
    :states 'normal
    :prefix "<leader> i"
    :prefix-command 'Insert
    "s" '("Insert snippet" . yas-insert-snippet)))

(use-package yasnippet-snippets
  :config
  (evil-global-set-key 'normal (kbd "<leader> i s") 'yas-insert-snippet))

(use-package doom-snippets
  :after yasnippet
  :straight (doom-snippets :type git :host github :repo "doomemacs/snippets" :files ("*.el" "*")))


(use-package emacs
  :custom
  ;; Emacs 28 and newer: Hide commands in M-x which do not apply to the current
  ;; mode.  Corfu commands are hidden, since they are not used via M-x. This
  ;; setting is useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p))
