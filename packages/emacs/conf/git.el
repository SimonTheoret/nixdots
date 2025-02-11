;; -*- lexical-binding: t -*-

;; git magic!

;; Ediff
(setq ediff-window-setup-function #'ediff-setup-windows-plain)

;; magit
(use-package
  magit
  :defer 0.3 
  :after evil-collection
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)
  :general-config
  (general-def
    :states 'normal
    :prefix "<leader> g"
    :prefix-command 'Git
    "/" '("Magit" . magit)
    "l" '("Magit status" . magit-log)
    "t" '("Git TimeMachine" . git-timemachine)
    "s s" '("SMerge mode" . smerge-mode)
    "s n" '("SMerge next" . smerge-next)
    "s p" '("SMerge previous" . smerge-prev)
    "s k" '("SMerge keep current" . smerge-keep-current)
    "s l" '("SMerge keep lower" . smerge-keep-lower)
    "s u" '("SMerge keep upper" . smerge-keep-upper)
    "s a" '("SMerge keep all" . smerge-keep-all)
    ))

(use-package magit-todos :after magit :config (magit-todos-mode 1) (setq magit-todos-exclude-globs '("*.ipynb")))

(use-package git-modes)

(use-package git-timemachine)

