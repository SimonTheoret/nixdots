;; -*- lexical-binding: t -*- 

;; Projects manager

;; projectile
(use-package
  projectile
  :config (projectile-mode +1) (setq projectile-project-search-path '("~/Documents"))
  :general-config
  (general-def
    :states
    'normal
    "<leader> p m" '("Projectile command map" . projectile-command-map)
    "<leader> SPC" '("Project find file in project" . projectile-find-file)
    "<leader> p p" '("Project Switch project" . projectile-switch-project)
    "<leader> p a" '("Project Add project" . projectile-add-known-project)
    "<leader> p d" '("Project Remove project" . projectile-remove-known-project)))

