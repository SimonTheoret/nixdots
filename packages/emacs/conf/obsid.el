;; -*- lexical-binding: t -*-


(defun obsidian-daily-note-other-window ()
  "Open a `obsidian-daily-note' in a new window."
  (interactive)
  (let ((buf (obsidian-daily-note)))
    (switch-to-buffer (other-buffer buf))
    (switch-to-buffer-other-window buf)))

(use-package obsidian
  :defer 3
  :config
  (obsidian-specify-path "~/org")
  (global-obsidian-mode t)
  :custom
  ;; This directory will be used for `obsidian-capture' if set.
  (obsidian-inbox-directory "pile")
  ;; Create missing files in inbox? - when clicking on a wiki link
  ;; t: in inbox, nil: next to the file with the link
  ;; default: t
					;(obsidian-wiki-link-create-file-in-inbox nil)
  ;; The directory for daily notes (file name is YYYY-MM-DD.md)
  (obsidian-daily-notes-directory "daily")
  ;; Directory of note templates, unset (nil) by default
					;(obsidian-templates-directory "Templates")
  ;; Daily Note template name - requires a template directory. Default: Daily Note Template.md
					;(obsidian-daily-note-template "Daily Note Template.md")
  :general
  (general-def
    :states 'normal
    :prefix "<leader> n" ;; This prefix definition must be placed AFTER the definition of the Org prefix
    :prefix-command 'Obsidian
    ;; Replace C-c C-o with Obsidian.el's implementation. It's ok to use another key binding.
    "g" '("Follow thing" . obsidian-follow-link-at-point)
    ;; Jump to backlinks
    "b" '("Follow backlink" . obsidian-backlink-jump)
    ;; If you prefer you can use `obsidian-insert-link'
    "i" '("Insert link" . obsidian-insert-link)
    "t" '("Daily note" . obsidian-daily-note)
    "T" '("Daily note" . obsidian-daily-note-other-window)
    "j" '("Obsidian jump" . obsidian-jump)
    "s" '("Regex notes" . obsidian-search)
    "c" '("Capture note" . obsidian-capture)
    "f" '("Search dir" . search-org-dir)
    "u" '("Update obsidian.el" . obsidian-update)
    "y" '("Yesterday daily" . obsidian-yesterday-note)
    "n" '("Tomorrow daily" . obsidian-tomorrow-note)
    "Y" '("Yesterday daily" . obsidian-yesterday-note-other-window)
    "N" '("Tomorrow daily" . obsidian-tomorrow-note-other-window)
    )
  )

(defun search-org-dir ()
  (interactive)
  (ido-find-file-in-dir "~/org" ))


(defun yesterday-yyyy-mm-dd-string ()
  "Returns back yesterday date in the `yyyy-mm-dd` format, as a string"
  (interactive)

  (format-time-string "%Y-%m-%d"  (encode-time (decoded-time-add (decode-time) (make-decoded-time :day -1 ))))
  )

(defun tomorrow-yyyy-mm-dd-string ()
  "Returns back tomorrow date in the `yyyy-mm-dd` format, as a string"
  (interactive)
  (format-time-string "%Y-%m-%d"  (encode-time (decoded-time-add (decode-time) (make-decoded-time :day 1 ))))
  )

;; (defun obsidian-tomorrow-file ()
;;   (interactive)
;;   (find-file (concat "~/org/daily/"  
;; 		     (tomorrow-yyyy-mm-dd-string)
;; 		     ".md"
;; 		     )
;; 	     )
;;   )

;; (defun obsidian-tomorrow-note-other-window ()
;;   (interactive)
;;   (find-file-other-window (concat "~/org/daily/"  
;; 				  (tomorrow-yyyy-mm-dd-string)
;; 				  ".md"
;; 				  )
;; 			  )
;;   )

;; (defun obsidian-yesterday-file ()
;;   (interactive)
;;   (find-file (concat "~/org/daily/"  
;; 		     (yesterday-yyyy-mm-dd-string)
;; 		     ".md"
;; 		     )
;; 	     )
;;   )
;; (defun obsidian-yesterday-note-other-window ()
;;   (interactive)
;;   (find-file-other-window (concat "~/org/daily/"  
;; 				  (yesterday-yyyy-mm-dd-string)
;; 				  ".md"
;; 				  )
;; 			  )
;;   )

(defun obsidian-yesterday-note-other-window ()
  "Create new obsidian daily note.

In the `obsidian-daily-notes-directory' if set otherwise in `obsidian-inbox-directory' - if that's also unset,
in `obsidian-directory' root. Opens the file in an other window."
  (interactive)
  (let* ((title (yesterday-yyyy-mm-dd-string))
         (filename (s-concat obsidian-directory "/" obsidian-daily-notes-directory "/" title ".md"))
         (clean-filename (s-replace "//" "/" filename)))
    (find-file-other-window (expand-file-name clean-filename) t)
    (save-buffer)
    (if (and obsidian-templates-directory obsidian-daily-note-template (eq (buffer-size) 0))
        (progn
          (obsidian-apply-template (s-concat obsidian-directory "/" obsidian-templates-directory "/" obsidian-daily-note-template))
          (save-buffer)))
    (add-to-list 'obsidian-files-cache clean-filename)))

(defun obsidian-yesterday-note ()
  "Create new obsidian daily note from yesterday.

In the `obsidian-daily-notes-directory' if set otherwise in `obsidian-inbox-directory' - if that's also unset,
in `obsidian-directory' root. Opens the file in an other window."
  (interactive)
  (let* ((title (yesterday-yyyy-mm-dd-string))
         (filename (s-concat obsidian-directory "/" obsidian-daily-notes-directory "/" title ".md"))
         (clean-filename (s-replace "//" "/" filename)))
    (find-file (expand-file-name clean-filename) t)
    (save-buffer)
    (if (and obsidian-templates-directory obsidian-daily-note-template (eq (buffer-size) 0))
        (progn
          (obsidian-apply-template (s-concat obsidian-directory "/" obsidian-templates-directory "/" obsidian-daily-note-template))
          (save-buffer)))
    (add-to-list 'obsidian-files-cache clean-filename)))


(defun obsidian-tomorrow-note ()
  "Create new obsidian daily note from tomorrow.

In the `obsidian-daily-notes-directory' if set otherwise in `obsidian-inbox-directory' - if that's also unset,
in `obsidian-directory' root. Opens the file in an other window."
  (interactive)
  (let* ((title (tomorrow-yyyy-mm-dd-string))
         (filename (s-concat obsidian-directory "/" obsidian-daily-notes-directory "/" title ".md"))
         (clean-filename (s-replace "//" "/" filename)))
    (find-file (expand-file-name clean-filename) t)
    (save-buffer)
    (if (and obsidian-templates-directory obsidian-daily-note-template (eq (buffer-size) 0))
        (progn
          (obsidian-apply-template (s-concat obsidian-directory "/" obsidian-templates-directory "/" obsidian-daily-note-template))
          (save-buffer)))
    (add-to-list 'obsidian-files-cache clean-filename)))


(defun obsidian-tomorrow-note-other-window ()
  "Create new obsidian daily note from tomorrow.

In the `obsidian-daily-notes-directory' if set otherwise in `obsidian-inbox-directory' - if that's also unset,
in `obsidian-directory' root. Opens the file in an other window."
  (interactive)
  (let* ((title (tomorrow-yyyy-mm-dd-string))
         (filename (s-concat obsidian-directory "/" obsidian-daily-notes-directory "/" title ".md"))
         (clean-filename (s-replace "//" "/" filename)))
    (find-file-other-window (expand-file-name clean-filename) t)
    (save-buffer)
    (if (and obsidian-templates-directory obsidian-daily-note-template (eq (buffer-size) 0))
        (progn
          (obsidian-apply-template (s-concat obsidian-directory "/" obsidian-templates-directory "/" obsidian-daily-note-template))
          (save-buffer)))
    (add-to-list 'obsidian-files-cache clean-filename)))

(defun obsidian-daily-note-other-window ()
  "Create new obsidian daily note.

In the `obsidian-daily-notes-directory' if set otherwise in `obsidian-inbox-directory' - if that's also unset,
in `obsidian-directory' root. Opens the file in an other window.
."
  (interactive)
  (let* ((title (format-time-string "%Y-%m-%d"))
         (filename (s-concat obsidian-directory "/" obsidian-daily-notes-directory "/" title ".md"))
         (clean-filename (s-replace "//" "/" filename)))
    (find-file-other-window (expand-file-name clean-filename) t)
    (save-buffer)
    (if (and obsidian-templates-directory obsidian-daily-note-template (eq (buffer-size) 0))
        (progn
          (obsidian-apply-template (s-concat obsidian-directory "/" obsidian-templates-directory "/" obsidian-daily-note-template))
          (save-buffer)))
    (add-to-list 'obsidian-files-cache clean-filename)))
