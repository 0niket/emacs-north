;;; init.el --- Emacs Configuration for Full-Stack Development
;;; Commentary:
;;; Comprehensive Emacs setup for JS, TS, HTML, CSS, Ruby, Rails, SQL, Postgres, Apex, LWC
;;; with LSP support, git integration, project management, and Claude Code integration

;;; Code:

;; ============================================================================
;; PACKAGE MANAGEMENT SETUP
;; ============================================================================

;; Set up package repositories
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package if not already installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; ============================================================================
;; BASIC EMACS SETTINGS
;; ============================================================================

;; Disable startup screen
(setq inhibit-startup-message t)

;; Clean UI
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(menu-bar-mode -1)          ; Disable the menu bar

;; Line numbers
(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Font settings
;; Using Monaco (macOS built-in monospace font)
;; You can install Fira Code later with: brew install --cask font-fira-code
(set-face-attribute 'default nil :font "Monaco" :height 140)

;; macOS key bindings - Use Command as Meta key
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

;; Better scrolling
(setq scroll-margin 3
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; Better completion
(setq completion-ignore-case t
      read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t)

;; Backup settings
(setq backup-directory-alist '(("." . "~/.emacs.d/backups"))
      auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t))
      backup-by-copying t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Better defaults
(setq-default indent-tabs-mode nil
              tab-width 2
              fill-column 100)

;; Auto revert files when changed externally
(global-auto-revert-mode 1)

;; Remember cursor position
(save-place-mode 1)

;; Save minibuffer history
(savehist-mode 1)

;; Better help
(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . helpful-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-key] . helpful-key))

;; ============================================================================
;; WHICH-KEY - Show keybinding hints
;; ============================================================================

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;; ============================================================================
;; THEME AND UI
;; ============================================================================

;; Icons (must be installed before doom-modeline)
(use-package all-the-icons
  :if (display-graphic-p))

;; Doom themes
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

;; Doom modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 25)
  (doom-modeline-bar-width 3)
  (doom-modeline-lsp t)
  (doom-modeline-github nil)
  (doom-modeline-minor-modes nil)
  (doom-modeline-icon nil)  ;; Disable icons to avoid rendering issues
  (doom-modeline-buffer-file-name-style 'truncate-upto-project))

;; Rainbow delimiters for better parenthesis matching
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Highlight current line
(global-hl-line-mode 1)

;; ============================================================================
;; COMPLETION FRAMEWORK (Vertico, Consult, Orderless, Corfu)
;; ============================================================================

;; Vertico - vertical completion UI
(use-package vertico
  :init
  (vertico-mode)
  :custom
  (vertico-cycle t))

;; Savehist - persist history over Emacs restarts
(use-package savehist
  :init
  (savehist-mode))

;; Orderless - flexible matching style
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; Marginalia - richer annotations in minibuffer
(use-package marginalia
  :init
  (marginalia-mode))

;; Consult - consulting completing-read
(use-package consult
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ("C-c k" . consult-kmacro)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)
         ("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x 5 b" . consult-buffer-other-frame)
         ("C-x r b" . consult-bookmark)
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)
         ("M-g o" . consult-outline)
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s m" . consult-multi-occur)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)
         ("M-s e" . consult-isearch-history)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)
         ("M-r" . consult-history)))

;; Corfu - completion overlay
(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-delay 0.1)
  (corfu-auto-prefix 2)
  (corfu-quit-no-match 'separator)
  :init
  (global-corfu-mode))

;; ============================================================================
;; PROJECT MANAGEMENT - Projectile
;; ============================================================================

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'default))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/code")
    (setq projectile-project-search-path '("~/code")))
  (setq projectile-switch-project-action #'projectile-dired))

;; Projectile Rails support
(use-package projectile-rails
  :after projectile
  :config
  (projectile-rails-global-mode))

;; ============================================================================
;; GIT INTEGRATION - Magit
;; ============================================================================

(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  :bind
  ("C-x g" . magit-status))

;; Show git diff in fringe
(use-package diff-hl
  :config
  (global-diff-hl-mode)
  (diff-hl-flydiff-mode))

;; ============================================================================
;; TREE-SITTER SETUP
;; ============================================================================

;; Ensure tree-sitter is available
(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; ============================================================================
;; LSP MODE - Language Server Protocol
;; ============================================================================

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t)
  :custom
  (lsp-headerline-breadcrumb-enable t)
  (lsp-log-io nil)
  (lsp-idle-delay 0.500)
  (lsp-enable-file-watchers t)
  (lsp-file-watch-threshold 2000))

;; LSP UI for better visuals
(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :custom
  (lsp-ui-doc-position 'bottom)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-delay 0.5))

;; LSP Treemacs integration
(use-package lsp-treemacs
  :after lsp-mode
  :commands lsp-treemacs-errors-list)

;; ============================================================================
;; JAVASCRIPT & TYPESCRIPT
;; ============================================================================

;; Use built-in tree-sitter modes for JS/TS
(use-package typescript-ts-mode
  :ensure nil
  :mode (("\\.ts\\'" . typescript-ts-mode)
         ("\\.tsx\\'" . tsx-ts-mode))
  :hook ((typescript-ts-mode . lsp-deferred)
         (tsx-ts-mode . lsp-deferred))
  :custom
  (typescript-ts-mode-indent-offset 2))

;; JavaScript mode
(add-hook 'js-ts-mode-hook 'lsp-deferred)
(setq js-indent-level 2)

;; Prettier for formatting
(use-package prettier-js
  :hook ((js-ts-mode . prettier-js-mode)
         (typescript-ts-mode . prettier-js-mode)
         (tsx-ts-mode . prettier-js-mode)))

;; ============================================================================
;; HTML & CSS
;; ============================================================================

(use-package web-mode
  :mode (("\\.html\\'" . html-ts-mode)
         ("\\.css\\'" . css-ts-mode))
  :hook ((html-ts-mode . lsp-deferred)
         (css-ts-mode . lsp-deferred))
  :custom
  (css-indent-offset 2))

;; Emmet for HTML/CSS
(use-package emmet-mode
  :hook ((html-ts-mode . emmet-mode)
         (css-ts-mode . emmet-mode)
         (web-mode . emmet-mode)))

;; ============================================================================
;; RUBY & RUBY ON RAILS
;; ============================================================================

;; rbenv - Use rbenv Ruby instead of system Ruby
(use-package rbenv
  :config
  (global-rbenv-mode)
  ;; Ensure PATH includes rbenv shims
  (setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:" (getenv "PATH")))
  (setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims") exec-path)))

(use-package ruby-ts-mode
  :ensure nil
  :mode "\\.rb\\'"
  :hook (ruby-ts-mode . lsp-deferred)
  :custom
  (ruby-indent-level 2))

;; Inf-ruby for REPL
(use-package inf-ruby
  :hook (ruby-ts-mode . inf-ruby-minor-mode))

;; RSpec mode
(use-package rspec-mode
  :hook ruby-ts-mode
  :config
  ;; Use bundler for rspec commands
  (setq rspec-use-bundler-when-possible t)
  ;; Use rake when available
  (setq rspec-use-rake-when-possible nil))

;; Rubocop for linting
(use-package rubocop
  :hook (ruby-ts-mode . rubocop-mode))

;; ============================================================================
;; SQL & POSTGRES
;; ============================================================================

(use-package sql
  :ensure nil
  :mode (("\\.sql\\'" . sql-mode))
  :hook (sql-mode . lsp-deferred)
  :custom
  (sql-product 'postgres))

;; SQL formatting
(use-package sqlformat
  :hook (sql-mode . sqlformat-on-save-mode)
  :custom
  (sqlformat-command 'pgformatter))

;; ============================================================================
;; SALESFORCE APEX & LWC
;; ============================================================================

;; Apex mode - using java-mode as a substitute since apex-mode is not in MELPA
;; For better Apex support, you can install apex-mode manually or use java-mode
(add-to-list 'auto-mode-alist '("\\.cls\\'" . java-mode))
(add-to-list 'auto-mode-alist '("\\.trigger\\'" . java-mode))

;; LWC uses JS/HTML modes
;; Configure for LWC file structure
(add-to-list 'auto-mode-alist '("lwc/.*/.*\\.js\\'" . js-ts-mode))
(add-to-list 'auto-mode-alist '("lwc/.*/.*\\.html\\'" . html-ts-mode))

;; ============================================================================
;; SYNTAX CHECKING - Flycheck
;; ============================================================================

(use-package flycheck
  :init (global-flycheck-mode)
  :custom
  (flycheck-display-errors-delay 0.3))

;; ============================================================================
;; SNIPPETS - YASnippet
;; ============================================================================

(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :after yasnippet)

;; ============================================================================
;; TERMINAL - vterm
;; ============================================================================

(use-package vterm
  :commands vterm
  :config
  (setq vterm-max-scrollback 10000))

;; ============================================================================
;; CUSTOM KEYBINDINGS
;; ============================================================================

;; Better window navigation
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)

;; Comment/uncomment region
(global-set-key (kbd "C-c ;") 'comment-or-uncomment-region)

;; ============================================================================
;; PERFORMANCE TUNING
;; ============================================================================

;; Increase garbage collection threshold
(setq gc-cons-threshold (* 100 1024 1024))

;; Increase the amount of data Emacs reads from processes
(setq read-process-output-max (* 1024 1024))

;; ============================================================================
;; FINAL MESSAGE
;; ============================================================================

(message "Emacs configuration loaded successfully!")

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(rbenv vterm yasnippet-snippets yasnippet flycheck sqlformat rubocop rspec-mode emmet-mode web-mode prettier-js lsp-treemacs lsp-ui lsp-mode treesit-auto diff-hl magit projectile-rails projectile corfu consult marginalia orderless vertico rainbow-delimiters doom-modeline doom-themes all-the-icons which-key helpful)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
