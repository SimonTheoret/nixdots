;; -*- lexical-binding: t -*- 

;; highlight symbol
;; (use-package highlight-thing
;;   :init
;;   (global-highlight-thing-mode)
;;   :hook
;;   (prog-mode . highlight-thing-mode)
;;   :config
;;   (setq highlight-thing-delay-seconds 0.25))


;; Used only in python mode
(use-package highlight-indent-guides
  :hook
  (python-ts-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character))

