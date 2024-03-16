;; -*- lexical-binding: t -*- 

(use-package
 exec-path-from-shell
 :init
 (when (memq window-system '(mac ns x))
   (exec-path-from-shell-initialize))
 (when (daemonp)
  (exec-path-from-shell-initialize)))

