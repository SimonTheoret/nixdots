;; -*- lexical-binding: t -*- 

(use-package apheleia :init (apheleia-global-mode +1)
  :config
  (setf (alist-get 'isort apheleia-formatters)
	'("isort" "--stdout" "--profile" "black"))
  (setf (alist-get 'flake8 apheleia-formatters)
	'("flake8"
          "--tee"
          "--extend-ignore"
          "E203"
          "--max-line-length"
          "88"))
  (setf (alist-get 'python-mode apheleia-mode-alist)
	'(isort flake8 black)))
