;; -*- lexical-binding: t -*-


;; Debug to add bugs

;; (use-package dap-mode
;;   :config
;;   (require 'dap-python)
;;   ;; if you installed debugpy, you need to set this
;;   ;; https://github.com/emacs-lsp/dap-mode/issues/306
;;   (setq dap-python-debugger 'debugpy)
;;   (require 'dap-gdb-lldb)
;;   (dap-gdb-lldb-setup)
;;   (dap-register-debug-template "Rust::GDB Run Configuration"
;;                                (list :type "gdb"
;;                                      :request "launch"
;;                                      :name "GDB::Run"
;; 				     :gdbpath "rust-gdb"
;;                                      :target nil
;;                                      :cwd nil))
;;   :general
;;   (general-def
;;     :states 'normal
;;     :prefix "<leader> d"
;;     :prefix-command 'Dap
;;     "t" '("Toggle breakpoint" . dap-breakpoint-toggle )
;;     "f" '("Condition for breakpoint" . dap-breakpoint-condition )
;;     "e" '("Eval thing" . dap-eval-thing-at-point)
;;     "n" '("Dap next" . dap-next )
;;     "i" '("Step in" . dap-step-in )
;;     "o" '("Step out" . dap-step-out )
;;     "c" '("Continue" . dap-continue )
;;     "q" '("Quit Dap" . dap-disconnect )
;;     "d" '("Dap debug" . dap-debug )
;;     "r" '("Dap relaunch recent" . dap-debug-recent )
;;     "l" '("Dap relaunch last" . dap-debug-last )
;;     "u" '("Dap ui repl" . dap-ui-repl )
;;     "s" '("Eval string" . dap-eval )
;;     )
;;   )
;; (use-package dap-LANGUAGE) to load the dap adapter for your language
