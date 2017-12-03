;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation nil
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     (auto-completion :variables
                      ;;                 auto-completion-return-key-behavior 'complete
                      ;;                 auto-completion-tab-key-behavior 'cycle
                      ;;                 auto-completion-complete-with-key-sequence nil
                      ;;                 auto-completion-complete-with-key-sequence-delay 0
                      ;;                 auto-completion-private-snippets-directory nil
                      auto-completion-enable-snippets-in-popup t
                      ;;                 auto-completion-enable-help-tooltip t
                      auto-completion-enable-sort-by-usage t
                      :disabled-for org markdown)
     better-defaults
     (chinese :packages youdao-dictionary
              :variables chinese-enable-youdao-dict t)
     emacs-lisp
     (git :variables
          git-magit-status-fullscreen t
          magit-push-always-verify nil
          magit-save-repository-buffers 'dontask
          magit-revert-buffers 'silent
          magit-refs-show-commit-count 'all
          magit-revision-show-gravatars nil)
     github
     javascript
     (typescript :variables
                 typescript-fmt-on-save nil
                 typescript-fmt-tool 'typescript-formatter)
     bibtex
     ;; helm
     ivy
     yaml
     (latex :variables latex-enable-auto-fill t)
     (c-c++ :variables
            c-c++-default-mode-for-headers 'c++-mode)
     (ess :variables ess-enable-smart-equals t)
     racket
     (python :variables
             python-test-runner '(nose pytest)
             python-enable-yapf-format-on-save t)
     ipython-notebook
     markdown
     (org :variables org-enable-reveal-js t org-want-todo-bindings t)
     (shell :variables
            shell-default-shell 'eshell)
     (syntax-checking :variables
                      syntax-checking-enable-by-default t
                      syntax-checking-enable-tooltips t)
     (spell-checking :variables
                     spell-checking-enable-by-default t)
     version-control
     (colors :variables
             colors-enable-nyan-cat-progress-bar t)
     nlinum
     pandoc
     semantic
     graphviz
     (ranger :variables ranger-show-preview t)
     pdf-tools
     prodigy
     search-engine
     (vinegar :variables vinegar-reuse-dired-buffer t)
     (spacemacs-layouts :variables layouts-enable-autosave nil
                        layouts-autosave-delay 300)
     (ibuffer :variables ibuffer-group-buffers-by 'projects)
     restclient
     (gtags :disabled-for clojure emacs-lisp javascript latex python shell-scripts ess)
     docker
     deft
     shaders
     react
     (ruby :variables ruby-version-manager 'chruby)
     ruby-on-rails
     lua
     html
     (clojure :variables clojure-enable-fancify-symbols t)
     gnus
     (mu4e :variables
           mu4e-installation-path "/usr/share/emacs/site-lisp/mu4e"
           mu4e-account-alist t)
     elfeed
     octave
     )
   dotspacemacs-additional-packages '(
                                      nodejs-repl
                                      youdao-dictionary
                                      chinese-yasdcv
                                      req-package
                                      blog-admin
                                      ob-ipython
                                      pangu-spacing
                                      linum-off
                                      editorconfig
                                      emmet-mode
                                      crux
                                      emms
                                      company-math
                                      org-edit-latex
                                      )
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages '(exec-path-from-shell)
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update nil
   dotspacemacs-elpa-subdirectory nil
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light
                         solarized-light
                         solarized-dark
                         leuven
                         monokai
                         zenburn)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '(
                               "Fira Mono"
                               ;; "Inconsolata"
                               ;; "Droid Sans Mono"
                               ;; "Ubuntu Mono"
                               ;; "Source Code Pro"
                               ;; "DejaVu Sans Mono"
                               ;; "Source Han Sans CN"
                               ;;"WenQuanYi Micro Hei Mono"
                               :size 16
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-ex-command-key ":"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-retain-visual-state-on-shift t
   dotspacemacs-visual-line-move-text nil
   dotspacemacs-ex-substitute-global nil
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-large-file-size 20
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-helm-use-fuzzy 'always
   dotspacemacs-enable-paste-transient-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup t
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers t
   dotspacemacs-folding-method 'evil
   dotspacemacs-smartparens-strict-mode t
   dotspacemacs-smart-closing-parenthesis t
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("pt" "ag" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  (setq configuration-layer--elpa-archives
      '(("melpa-cn" . "https://elpa.zilongshanren.com/melpa/")
        ("org-cn"   . "https://elpa.zilongshanren.com/org/")
        ("gnu-cn"   . "https://elpa.zilongshanren.com/gnu/")))
  )

(defun dotspacemacs/user-config ()
  (setenv "IPY_TEST_SIMPLE_PROMPT" "1")
  (require 'ob-tangle)
  (org-babel-load-file
    (expand-file-name "lengyueyang.org"
                      dotspacemacs-directory))
  )

(setq custom-file (expand-file-name "custom.el" dotspacemacs-directory))
(load custom-file 'no-error 'no-message)
