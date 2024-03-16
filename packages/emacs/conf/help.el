;; -*- lexical-binding: t -*- 


(use-package helpful
  :general
  ("C-h f"   '("callable help" . helpful-callable)
   "C-h v"   '("variable help" . helpful-variable)
   "C-h k"   '("key help" . helpful-key)
   "C-h x"   '("command help" . helpful-command)
   "C-c C-d" '("help at point" . helpful-at-point)
   "C-h F"   '("help function" . helpful-function)
   )
  )

