;; -*- lexical-binding: t -*- 

;;;;;;;;; org-mode ;;;;;;;;

;; org-mode prettify
;; (use-package org-superstar
;;   :init
;;   (require 'org-superstar)
;;   :hook
;;   (org-mode . (lambda () (org-superstar-mode 1))))

;; (use-package org-fancy-priorities
;;   :hook
;;   (org-mode . org-fancy-priorities-mode)
;;   :config
;;   (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")))

(defun org--set-latex-scale ()
  (plist-put org-format-latex-options :scale 1.5)
  (message "Setting latex preview options completed"))

(setq
 ;; Edit settings
 org-return-follows-link t
 org-auto-align-tags nil
 org-tags-column 0
 org-catch-invisible-edits 'show-and-error
 org-special-ctrl-a/e t
 org-insert-heading-respect-content t

 ;; Org styling, hide markup etc.
 org-hide-emphasis-markers t
 org-pretty-entities t
 ;;org-ellipsis "…"
 org-ellipsis " "

 ;; Agenda styling
 org-agenda-tags-column 0
 org-agenda-block-separator ?─
 org-agenda-time-grid
 '((daily today require-timed)
   (800 1000 1200 1400 1600 1800 2000)
   " ┄┄┄┄┄ "
   "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
 org-agenda-current-time-string "◀── now ─────────────────────────────────────────────────"
 org-cycle-hide-block-startup t
 org-startup-folded t
 org-startup-indented t
 org-agenda-files '("~/org/agenda/agenda.org")
 org-directory '("~/org/agenda"))

;; Pretty indenting
(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook #'org--set-latex-scale)


(use-package
  org-modern
  :after org
  :hook
  ((org-mode . org-modern-mode)
   (org-agenda-finalize . org-modern-agenda)))

;; Prettify windows. Should be in looks.el ?
;; (modify-all-frames-parameters
;;  '((right-divider-width . 40)
;;    (internal-border-width . 40)))
;; (dolist (face '(window-divider
;;                 window-divider-first-pixel
;;                 window-divider-last-pixel))
;;   (face-spec-reset-face face)
;;   (set-face-foreground face (face-attribute 'default :background)))
;; (set-face-background 'fringe (face-attribute 'default :background))


;; org roam v2 
(use-package
  org-roam
  :custom (org-roam-directory (file-truename "~/org/roam"))
  :general
  (general-def

    :states 'normal

    "<leader> n r l"
    '("Roam buffer toggle" . org-roam-buffer-toggle)
    "<leader> n r f"
    '("Roam find node" . org-roam-node-find)
    "<leader> n r g"
    '("Roam graph" . org-roam-graph)
    "<leader> n r i"
    '("Roam insert node " . org-roam-node-insert)
    "<leader> n r c"
    '("Roam capture" . org-roam-capture)
    "<leader> n r c"
    '("Dailies capture today" . org-roam-dailies-capture-today)
    "<leader> n r t"
    '("Dailies goto yesterday" . org-roam-dailies-goto-today)
    "<leader> n r y"
    '("Dailies goto yesterday" . org-roam-dailies-goto-yesterday)
    )
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template
	(concat
         "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol)
  (setq org-roam-dailies-directory "org/daily")

  (setq
   org-roam-dailies-capture-templates
   '(("d"
      "default"
      entry
      "* %?"
      :target (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n")))))


(general-def
  :states
  'normal
  "<leader> n a a"
  '("Org agenda" . org-agenda)
  "<leader> n c c"
  '("Org capture" . org-capture)
  "<leader> n a f"
  '("Org agenda file" . org-cycle-agenda-files))


(general-def
  :states 'normal
  :keymaps 'org-mode-map

  ;; Org nodes
  "<leader> m n n"
  '("New node" . org-id-get-create)
  ;; Toggling
  "<leader> m t c"
  '("Toggle checkbox" . org-toggle-checkbox)
  "<leader> m t h"
  '("Toggle heading" . org-toggle-heading)
  "<leader> m t i"
  '("Toggle item" . org-toggle-item)
  "<leader> m t t"
  '("Toggle todo" . org-todo)
  "<leader> m i t"
  '("Insert heading/checkbox" . org-insert-todo-heading)
  ;; Archive
  "<leader> m a d"
  '("Archive subtree" . org-archive-subtree-default)
  ;; Ctrl-c ctrl-c magic
  "<leader> m c c"
  '("Org ctrl-c" . org-ctrl-c-ctrl-c)
  ;; Links
  "<leader> m l s"
  '("Org store link" . org-store-link)
  "<leader> m l i"
  '("Org store link" . org-insert-link)
  "<return>"
  '("Follow link" . org-open-at-point)
  ;; Latex
  "<leader> m m p"
  '("Org store link" . org-latex-preview))


;; Org capture templates
(setq
 org-capture-templates

 '(("r" "Évènements récurrents" plain
    (file+headline
     "~/org/agenda/agenda.org" "Évènements récurrents")
    "** %?%(org-insert-time-stamp nil nil nil nil nil \" +1w\")")

   ("u" "Évènements uniques" plain
    (file+headline
     "~/org/agenda/agenda.org" "Évènements uniques")
    "** %?%^T")

   ("t"
    "Tâches uniques"
    plain
    (file+headline "~/org/agenda/agenda.org" "Tâches uniques")
    "** TODO %? DEADLINE: %^T")
   ("g"
    "Tâches récurrentes"
    plain
    (file+headline "~/org/agenda/agenda.org" "Tâches récurrentes")
    "** TODO %? DEADLINE: %(org-insert-time-stamp nil nil nil nil nil \" +1w\")")

   ("e"
    "École"
    plain
    (file+headline "~/org/agenda/agenda.org" "École")
    "** TODO %? DEADLINE: %^t :école:")

   ("i"
    "Inbox"
    plain
    (file+headline "~/org/todo.org" "Inbox")
    "** TODO %?")

   ("c" "Tâche contextuelles" plain
    (file+headline
     "~/org/agenda/agenda.org" "Tâches contextuelles")
    "** %?")

   ("a" "Tâches en attentes" plain
    (file+headline
     "~/org/agenda/agenda.org" "Tâches en attentes")
    "** %?")

   ("p"
    "Projets"
    plain
    (file+headline "~/org/agenda/agenda.org" "Projets")
    "** %?")))
