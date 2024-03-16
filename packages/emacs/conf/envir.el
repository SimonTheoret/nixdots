;; -*- lexical-binding: t -*- 

(use-package envrc
  :init
  (envrc-global-mode)
  :general-config
  (general-def 'normal
    "<leader> e e" #'envrc-reload))
