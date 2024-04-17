;; -*- lexical-binding: t -*-

;; (autoload 'notmuch "notmuch" "notmuch mail" t)
;; (use-package notmuch)

;; (use-package notmuch-notify ;;useful?
;;   :straight (notmuch-notify :type git :host github :repo "firmart/notmuch-notify")
;;   :hook (notmuch-hello-refresh . notmuch-notify-hello-refresh-status-message)
;;   :config
;;   ;; (Recommended) activate system-wise notification timer
;;   (notmuch-notify-set-refresh-timer))

;; (setq
;;  send-mail-function 'sendmail-send-it
;;  smtpmail-smtp-server "smtp-mail.outlook.com"
;;  smtpmail-smtp-service 587
;;  )

(use-package mu4e
  :straight
  (:local-repo "/etc/profiles/per-user/simon/share/emacs/site-lisp/mu4e"
               :type built-in)
  :commands (mu4e)
  :config
  (setq sendmail-program (executable-find "msmtp")
        send-mail-function #'smtpmail-send-it
        message-sendmail-f-is-evil t
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-send-mail-function #'message-send-mail-with-sendmail
	mu4e-context-policy 'ask-if-none
	mu4e-compose-context-policy 'always-ask
	mu4e-get-mail-command "mbsync --all"
	mu4e-update-interval 300
	user-mail-address "simonteoret@hotmail.com")
  (add-to-list 'mu4e-view-actions
	       '("View in Browser" . mu4e-action-view-in-browser) t)
  :general
  (general-def
    :states 'normal
    :prefix "<leader> v"
    :prefix-command 'Mail
    "m" '("Mu4e" . mu4e)
    )
  )


(setq browse-url-browser-function 'browse-url-generic)
(setq browse-url-generic-program "firefox")

(general-def
  :states
  'normal
  :keymaps
  '(mu4e-headers-mode-map mu4e-view-mode-map)
  "o" '("Open message with method" . mu4e-views-view-current-msg-with-method )
  )

(use-package mu4e-alert
  :hook
  (after-init . mu4e-alert-enable-notifications)
  (after-init . mu4e-alert-enable-mode-line-display)
  :config
  (mu4e-alert-set-default-style 'notifications))

(use-package mu4e-views
  :after mu4e
  :straight (mu4e-views :type git :host github :repo "lordpretzel/mu4e-views")
  :config
  (setq mu4e-views-default-view-method "html-nonblock") ;; make xwidgets default
  (mu4e-views-mu4e-use-view-msg-method "html-nonblock") ;; select the default
  )
