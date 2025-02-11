;; -*- lexical-binding: t -*-

;; Projects manager

;; projectile
(use-package
  projectile
  :defer 0.5
  :config
  (projectile-mode +1)
  (setq projectile-project-search-path '("~/Documents"))
  (add-to-list 'projectile-globally-ignored-directories "nix")
  (add-to-list 'projectile-globally-ignored-directories ".cargo")
  :general-config
  (general-def
    :states
    'normal
    :prefix "<leader> p"
    :prefix-command 'Projectile
    "m" '("Projectile command map" . projectile-command-map)
    "p" '("Project switch project" . projectile-switch-project)
    "a" '("Project add project" . projectile-add-known-project)
    "d" '("Project remove project" . projectile-remove-known-project)
    )
  (general-def
    :states
    'normal
    "<leader> SPC" '("Find file in project" . projectile-find-file)
    "<leader> M-SPC" '("Find file in project" . projectile-find-file-other-window)
    )
  (general-def
    :states
    'normal
    "<leader> y" '("Projectile commands" . projectile-command-map)
    )
  )

