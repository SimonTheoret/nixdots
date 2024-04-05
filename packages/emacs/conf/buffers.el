;; -*- lexical-binding: t -*- 


(general-def
  :states 'normal
  :prefix "<leader> b"
  :prefix-command 'Buffers
  "i" '("Ibuffer" . ibuffer)
  "l" '("Buffer list" . consult-buffer))


(use-package popwin
  :config
  (popwin-mode 1))

