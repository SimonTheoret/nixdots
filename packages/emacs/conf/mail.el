;; -*- lexical-binding: t -*-

(use-package mu4e
  :straight (mu4e :host github :repo "emacsmirror/mu4e"
                  :files (:defaults "mu4e/*.el"))
  :defer t
  :general 
  (general-def
    :states 'normal
    :prefix "<leader> u"
    :prefix-command 'Mail
    "u" '("Mu4e" . mu4e)
    )
  )
