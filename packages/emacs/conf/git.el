;; -*- lexical-binding: t -*- 


;; git magic!

;; magit
(use-package
 magit
 :after evil-collection
 :general-config
 (general-def :states 'normal
   "<leader> g /" '("Magit" . magit)
   "<leader> g s"   '("Magit status" . magit-status)
   "<leader> g l"   '("Magit status" . magit-log)
   ))

(add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh) ;;compatibility with diff-hl
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh) ;;compatibility with diff-hl

(use-package magit-todos :after magit :config (magit-todos-mode 1))

