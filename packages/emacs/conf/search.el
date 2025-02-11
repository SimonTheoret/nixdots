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
  (setq vertico-resize 'grow-only)
  (setq vertico-cycle t)
  :general-config
  (
   :keymaps 'vertico-map
   :states 'insert
   "RET"
   #'vertico-directory-enter
   "DEL"
   #'vertico-directory-delete-char
   "M-DEL"
   #'vertico-directory-delete-word
   "C-n"
   #'vertico-next
   "C-p"
   #'vertico-previous
   )
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
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides
   '((file (styles basic partial-completion)))))

(use-package consult)

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))


(use-package
  embark
  :general
  (general-def
    :states 'normal
    :prefix "<leader> a"
    :prefix-command 'Actions
    "a" '("Embark act" . embark-act)
    "d" '("Embark dwim" . embark-dwim);; alternative for `describe-bindings'
    "s" '("Shell project command" . projectile-run-shell-command-in-root)
    "k" '("Async project command" . projectile-run-async-shell-command-in-root)
    "w" '("Shell buffer command " . shell-command)
    "i" '("Async buffer command" . async-shell-command)
    "v" '("Transient avy" . casual-avy-tmenu)
    )
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

(setq async-shell-command-display-buffer nil)

;; Consult users will also want the embark-consult package.
(use-package
  embark-consult
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(use-package browse-at-remote)

(use-package tldr :defer 1)

(use-package deadgrep)

(general-def
  :states
  'normal
  :prefix "<leader> s"
  :prefix-command 'Search
  "g"
  '("Filter search current dir" . lgrep)
  "d"
  '("Search current dir" . consult-ripgrep)
  "m"
  '("Multi occur" . multi-occur-in-matching-buffers)
  "o"
  '("Occur" . occur)
  "l"
  '("Search for line" . consult-line-multi)
  "b"
  '("Search in buffer" . consult-line)
  "s"
  '("Search and replace" . query-replace)
  "t"
  '("Search todos in buffers" . consult-todo-all)
  "h"
  '("Hide lines" . consult-focus-lines)
  "r"
  '("Deadgrep" . deadgrep)
  "a"
  '("Locate" . consult-locate)
  "x"
  '("Regex Builder" . re-builder)
  )

(general-def
  :states
  'normal
  :prefix "<leader> h"
  :prefix-command 'Help
  "r"
  '("Search file on remote" . browse-at-remote)
  "t"
  '("Tldr command" . tldr)
  "w"
  '("Manual with woman" . woman)
  "m"
  '("Manual with man" . man)
  )

;; (general-def
;;   :states
;;   'normal
;;   :pref)
