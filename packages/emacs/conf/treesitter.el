;; -*- lexical-binding: t -*-

;; Tree-sitter for emacs
;; (setq major-mode-remap-alist
;;       '((python-mode . python-ts-mode)
;; 	(rust-mode . rust-ts-mode)
;; 	(go-mode . go-ts-mode)
;; 	(dockerfile-mode . dockerfile-ts-mode)))
;;
(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
	(cmake "https://github.com/uyha/tree-sitter-cmake")
	(css "https://github.com/tree-sitter/tree-sitter-css")
	(elisp "https://github.com/Wilfred/tree-sitter-elisp")
	(go "https://github.com/tree-sitter/tree-sitter-go")
	(html "https://github.com/tree-sitter/tree-sitter-html")
	(javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
	(json "https://github.com/tree-sitter/tree-sitter-json")
	(make "https://github.com/alemuller/tree-sitter-make")
	(markdown "https://github.com/ikatyang/tree-sitter-markdown")
	(python "https://github.com/tree-sitter/tree-sitter-python")
	(toml "https://github.com/tree-sitter/tree-sitter-toml")
	(tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
	(typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
	(yaml "https://github.com/ikatyang/tree-sitter-yaml")
	(rust "https://github.com/tree-sitter/tree-sitter-rust")
	(elixir "https://github.com/elixir-lang/tree-sitter-elixir")
	(gleam "https://github.com/gleam-lang/tree-sitter-gleam")
	(heex "https://github.com/phoenixframework/tree-sitter-heex")
	)
      )

(defun install-ts-langs ()
  "Installs all the Treesitter parsers for the languages in `treesit-language-source-alist`"
  (interactive)
  (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))
  )

(add-hook 'prog-mode-hook (lambda ()
			    (treesit-font-lock-recompute-features '(function variable))))

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; (setq gleam-config
;;       (make-treesit-auto-recipe
;;        :lang 'gleam
;;        :ts-mode 'gleam-ts-mode
;;        :remap '( js-mode javascript-mode)
;;        :url "https://github.com/tree-sitter/tree-sitter-javascript"
;;        :revision "master"
;;        :source-dir "src"
;;        :ext "\\.js\\'"))
