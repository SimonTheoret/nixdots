;; -*- lexical-binding: t -*-

(defun change-compile-command (str)
  (set (make-local-variable 'compile-command) str))

(add-hook 'python-ts-mode-hook (apply-partially #'change-compile-command "python3 -m "))
(add-hook 'rustic-mode-hook (apply-partially #'change-compile-command "cargo "))
(add-hook 'rust-ts-mode-hook (apply-partially #'change-compile-command "cargo "))
(add-hook 'rust-mode-hook (apply-partially #'change-compile-command "cargo "))
(add-hook 'go-ts-mode (apply-partially #'change-compile-command "go "))
(add-hook 'sh-mode (apply-partially #'change-compile-command "bash "))
(add-hook 'gleam-ts-mode (apply-partially #'change-compile-command "gleam "))
(add-hook 'gleam-mode (apply-partially #'change-compile-command "gleam "))

(use-package fancy-compilation
  :commands (fancy-compilation-mode))

(with-eval-after-load 'compile
  (fancy-compilation-mode))

(general-def
  :states
  'normal
  :prefix "<leader> c"
  "c"
  '("Compile project" . projectile-compile-project)
  "C"
  '("Compile buffer" . compile)
  "r"
  '("Recompile" . recompile)
  "l"
  '("Kill compilation" . kill-compilation)
  )
