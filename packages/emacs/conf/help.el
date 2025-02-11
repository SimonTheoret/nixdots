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

(use-package casual
  :general
  (general-def
    :states 'normal
    "<leader> a c" '("Calc" . calc)
    )
  )

(general-def
  :states 'normal
  :keymaps 'calc-mode-map
  "C-o" '("Calc transient" . casual-calc-tmenu)
  )

(general-def
  :states 'normal
  :keymaps 'reb-mode-map
  "C-o" '("Casual REbuilder" . casual-re-builder-tmenu)
  )

(general-def
  :states 'normal
  :keymaps 'ibuffer-mode-map
  "C-o" '("Transient ibuffer" . casual-ibuffer-tmenu))

(general-def
  :states
  'normal
  :keymaps 'dired-mode-map
  "C-o"
  '("Casual dired" .  casual-dired-tmenu)
  )

(general-def
  :states 'normal
  :keymaps 'isearch-mode-map
  "C-o" '("Casual isearch" . casual-isearch-tmenu)
  )

(general-def :states 'normal
  "<leader> C-o" '("Casual edikit" . casual-editkit-main-tmenu)
  )
