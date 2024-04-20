;; -*- lexical-binding: t -*-


;; TODO: Include dictionary
;; (setq )
;; (setq ispell-program-name "/etc/profiles/per-user/simon/bin/aspell") ;; re-add?
(setq ispell-dictionary "english")
(setq ispell-silently-savep t)

(general-def
  :states 'normal
  :prefix "<localleader> s"
  :prefix-command 'Spelling
  "i" '("Spelling in current buffer" . ispell)
  "s" '("Switch dict" . ispell-change-dictionary)
  )
