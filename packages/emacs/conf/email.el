;; -*- lexical-binding: t -*- 

;; (autoload 'notmuch "notmuch" "notmuch mail" t)
(use-package notmuch)

(use-package notmuch-notify ;;useful?
  :straight (notmuch-notify :type git :host github :repo "firmart/notmuch-notify")
  :hook (notmuch-hello-refresh . notmuch-notify-hello-refresh-status-message)
  :config
  ;; (Recommended) activate system-wise notification timer
  (notmuch-notify-set-refresh-timer))

(setq
 send-mail-function 'sendmail-send-it
 smtpmail-smtp-server "smtp-mail.outlook.com"
 smtpmail-smtp-service 587
 )
