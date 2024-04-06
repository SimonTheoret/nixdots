;; -*- lexical-binding: t -*-


;; git magic!

;; magit
(use-package
  magit
  :after evil-collection
  :general-config
  (general-def
    :states 'normal
    :prefix "<leader> g"
    :prefix-command 'Git
    "/" '("Magit" . magit)
    "s" '("Magit status" . magit-status)
    "l" '("Magit status" . magit-log)
    "t" '("Git TimeMachine" . git-timemachine)
    ))

(add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh) ;;compatibility with diff-hl
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh) ;;compatibility with diff-hl

(use-package magit-todos :after magit :config (magit-todos-mode 1))

(use-package git-modes)

(use-package git-timemachine)
