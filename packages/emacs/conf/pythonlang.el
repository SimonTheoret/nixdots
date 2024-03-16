;; -*- lexical-binding: t -*- 


(use-package
  pyvenv
  :hook
  (python-ts-mode . pyvenv-mode)
  (python-ts-mode . pyvenv-tracking-mode)
  ;; :config
  ;; (setq pyvenv-mode-line-indicator '(pyvenv-virtual-env-name ("[venv:" pyvenv-virtual-env-name "] ")))
  )

;; (use-package pyenv-mode
;;   :init
;;   (pyenv-mode))
;;

(use-package pip-requirements)


(use-package company-anaconda)
(eval-after-load "company"
  '(add-to-list
    'company-backends '(company-anaconda :with company-capf)))

(use-package
  pipenv
  :hook (python-ts-mode . pipenv-mode)
  :init
  (setq pipenv-projectile-after-switch-function
	#'pipenv-projectile-after-switch-default))

(use-package anaconda-mode
  :hook
  (python-ts-mode . anaconda-mode)
  (python-ts-mode . anaconda-eldoc-mode))
