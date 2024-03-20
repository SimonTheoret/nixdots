;; -*- lexical-binding: t -*- 

(use-package
 format-all
 :commands format-all-mode
 :hook (prog-mode . format-all-mode)
 :config
 (setq-default format-all-formatters
               '(("Rust" (rustfmt))
                 ("Shell" (shfmt "-i" "4" "-ci"))
                 ("Go" (gofumpt))
                 ("Python" (ruff "format"))
		 ("Nix" (nixfmt))
		 ("Lua" (lua-fmt)))))
