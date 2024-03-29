;; -*- lexical-binding: t -*- 

;; ALL THE RESULTS

;; Enable vertico
(use-package
  vertico
  :init (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  (setq vertico-count 15)
  :general-config
  (:keymaps
   'vertico-map
   "RET"
   #'vertico-directory-enter
   "DEL"
   #'vertico-directory-delete-char
   "M-DEL"
   #'vertico-directory-delete-word)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )


;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist :init (savehist-mode))

;; A few more useful configurations...
(use-package
  emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons
     (format "[CRM%s] %s"
             (replace-regexp-in-string
              "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" "" crm-separator)
             (car args))
     (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
	'(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)
  (setq help-window-select t) ; Switch to help buffers automatically

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))

(use-package
  orderless
  :custom (completion-styles '(orderless basic))
  (completion-category-overrides
   '((file (styles basic partial-completion)))))

(use-package consult)

(use-package consult-todo :after consult)

(use-package marginalia :config (marginalia-mode))

(defun search-emacs-dir ()
  (interactive)
  (ido-find-file-in-dir user-emacs-directory))

(general-def
  :states
  'normal
  :prefix "<leader> s"
  :prefix-command 'Search
  "g"
  '("Filter search current dir" . lgrep)
  "d"
  '("Search current dir" . consult-ripgrep)
  "f"
  '("Search file" . consult-fd)
  "m"
  '("Consult IMenu" . consult-imenu)
  )

(use-package
  embark

  :general
  (general-def
    :states 'normal
    :prefix "<leader> a"
    :prefix-command 'Actions
    "a" '("Embark act" . embark-act)
    "d" '("Embark dwim" . embark-dwim)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc. You may adjust the
  ;; Eldoc strategy, if you want to see the documentation from
  ;; multiple providers. Beware that using this can be a little
  ;; jarring since the message shown in the minibuffer can be more
  ;; than one line, causing the modeline to move up and down:

  ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list
   'display-buffer-alist
   '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
     nil
     (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package
  embark-consult
  :hook (embark-collect-mode . consult-preview-at-point-mode))
