;; -*- lexical-binding: t -*- 

(use-package envrc
  :init
  (envrc-global-mode)
  :general-config
  (general-def :states
    'normal
    "<leader> e e" '("Reload env vars" . envrc-reload)))
