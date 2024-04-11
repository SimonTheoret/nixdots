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


;; (add-hook 'org-mode-hook  #'rust-org-src-lang)

;; (defun rust-org-src-lang ()
;;   (add-to-list 'org-src-lang-modes '("rust" . rustic) )
;;   )

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


(general-def
  :states
  'normal
  :prefix "<leader> n c"
  :prefix-command 'Capture
  "c c"
  '("Org capture" . org-capture))

(general-def
  :states
  'normal
  :prefix "<leader> n a"
  :prefix-command 'Agenda
  "a"
  '("Org agenda" . org-agenda)
  "f"
  '("Org agenda file" . org-cycle-agenda-files))

;; org roam v2
(use-package org-roam
  :custom (org-roam-directory (file-truename "~/org/roam"))
  :general
  (general-def
    :states 'normal
    :prefix "<leader> n r" ;; This prefix definition must be placed AFTER the definition of the Org prefix
    :prefix-command 'Roam
    "l"
    '("Roam buffer toggle" . org-roam-buffer-toggle)
    "f"
    '("Roam find node" . org-roam-node-find)
    "g"
    '("Roam graph" . org-roam-graph)
    "i"
    '("Roam insert node " . org-roam-node-insert)
    "c"
    '("Roam capture" . org-roam-capture)
    "c"
    '("Dailies capture today" . org-roam-dailies-capture-today)
    "t"
    '("Dailies goto yesterday" . org-roam-dailies-goto-today)
    "y"
    '("Dailies goto yesterday" . org-roam-dailies-goto-yesterday))
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




(defun test-if-line-starts-with-char (char)
  "Tests if the line under the pointer starts with a char (string)
  character. If so, this function returns t. Else, it returns nil."
  (let* (
	 (myLine
	  (buffer-substring-no-properties
	   (line-beginning-position)
	   (line-end-position)))
	 (firstChar (substring myLine 0 ( + (-(length myLine)) 1)))
	 )
    (if (string-equal firstChar char)
	't
      nil)
    ))

(defun demote-heading-or-evil-default ()
  (interactive)
  (if (test-if-line-starts-with-char "*")
      (org-demote-subtree)
    (evil-shift-left-line 1)))

(defun promote-heading-or-evil-default ()
  (interactive)
  (if (test-if-line-starts-with-char "*")
      (org-promote-subtree)
    (evil-shift-right-line 1)))


(general-def
  :states 'normal
  :keymaps 'org-mode-map
  :prefix "<localleader> c"
  :prefix-command 'Ctrl-c
  "c"
  '("Org ctrl-c" . org-ctrl-c-ctrl-c))

(general-def
  :states 'normal
  :keymaps 'org-mode-map
  :prefix "<localleader> m"
  :prefix-command 'Math
  "p"
  '("Org preview latex" . org-latex-preview))

(general-def
  :states 'normal
  :keymaps 'org-mode-map
  :prefix "<localleader> n"
  :prefix-command 'Node
  "n n"
  '("New node" . org-id-get-create))



(general-def
  :states 'normal
  :keymaps 'org-mode-map
  :prefix "<localleader> l"
  :prefix-command 'Link
  "s"
  '("Org store link" . org-store-link)
  "i"
  '("Org store link" . org-insert-link))

(general-def
  :states 'normal
  :keymaps 'org-mode-map
  :prefix "<localleader> a"
  :prefix-command 'Archive
  "d"
  '("Archive subtree" . org-archive-subtree-default))

(general-def
  :states 'normal
  :keymaps 'org-mode-map
  :prefix "<localleader> i"
  :prefix-command 'Insert 
  "t"
  '("Insert heading/checkbox" . org-insert-todo-heading)
  "h"
  '("Insert heading" . org-insert-heading))

(general-def
  :states 'normal
  :keymaps 'org-mode-map
  :prefix "<localleader> t"
  :prefix-command 'Toggling 
  "c"
  '("Toggle checkbox" . org-toggle-checkbox)
  "h"
  '("Toggle heading" . org-toggle-heading)
  "i"
  '("Toggle item" . org-toggle-item)
  "t"
  '("Toggle todo" . org-todo))


(general-def
  :states 'normal
  :keymaps 'org-mode-map
  "<return>"
  '("Follow link" . org-open-at-point))


(general-def
  :states 'insert
  :keymaps 'org-mode-map
  "C-d"
  '("Promote or move left" . (lambda () (interactive) (promote-heading-or-evil-default)))
  "C-t"
  '("Demote or move right" . (lambda () (interactive) (demote-heading-or-evil-default)))
  )


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

