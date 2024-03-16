;; -*- lexical-binding: t -*- 


(general-def
  :states 'normal
  "<leader> b i" '("Ibuffer" . ibuffer)
  "<leader> b l" '("Buffer list" . consult-buffer))


(use-package popwin
  :config
  (popwin-mode 1))

