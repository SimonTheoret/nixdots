;; -*- lexical-binding: t -*-

(winner-mode)

(general-def
  :states 'normal
  :prefix "<leader> b"
  :prefix-command 'Buffers
  "i" '("Ibuffer project" . projectile-ibuffer)
  "I" '("Ibuffer" . ibuffer)
  "l" '("Buffer project list" . consult-project-buffer)
  "L" '("Buffer list" . consult-buffer)
  "r" '("Rename buffer" . rename-buffer)
  "f" '("Rename buffer and file" . crux-rename-buffer-and-file)
  "d" '("Delete current buffer" . kill-current-buffer)
  "s" '("Scratch buffer" . scratch-buffer)
  "n" '("Ibuffer mark by name" . ibuffer-mark-by-file-name-regexp)
  "b" '("Focus current buffer" . delete-other-windows)
  "m" '("Winner undo" . winner-undo)
  )

(use-package popwin
  :config
  (popwin-mode 1)
  :init
  (setq popwin:special-display-config '(("*Miniedit Help*" :noselect t)
					(help-mode :stick t)
					(completion-list-mode :noselect t)
					(compilation-mode :noselect t :stick t)
					(grep-mode :noselect t)
					(occur-mode :noselect t)
					("*Pp Macroexpand Output*" :noselect t)
					("*Async Shell Command*" :noselect t)
					"*Shell Command Output*"
					"*vc-diff*" "*vc-change-log*"
					(" *undo-tree*" :width 60 :position right)
					("^\\*anything.*\\*$" :regexp t)
					"*slime-apropos*" "*slime-macroexpansion*" "*slime-description*"
					("*slime-compilation*" :noselect t)
					"*slime-xref*"
					(sldb-mode :stick t)
					slime-repl-mode slime-connection-list-mode)

	)
  )


