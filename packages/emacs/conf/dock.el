(use-package docker
  :general
  (general-def
    :states 'normal
    :prefix "<leader> d"
    :prefix-command 'Docker
    "d" '("Docker" . docker)
    )
  )
