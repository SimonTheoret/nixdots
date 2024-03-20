;; -*- lexical-binding: t -*- 

(defun change-compile-command (str)
  (set (make-local-variable 'compile-command) str))

(add-hook 'python-ts-mode-hook (apply-partially #'change-compile-command "python -m "))
(add-hook 'rustic-mode-hook (apply-partially #'change-compile-command "cargo "))
(add-hook 'go-ts-mode (apply-partially #'change-compile-command "go "))
(add-hook 'sh-mode (apply-partially #'change-compile-command "bash "))
